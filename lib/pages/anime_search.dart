import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:data_nime/widget/app_drawer.dart';
import 'package:data_nime/widget/card_preview_anime.dart';
import 'package:data_nime/domain/entities/anime_preview.dart';
import 'package:data_nime/data/services/jikan_service.dart';
import 'package:data_nime/widget/genre_filter.dart';
import 'package:data_nime/utils/google_translator.dart';
import 'package:data_nime/pages/anime_info.dart';

class Genre {
  final int id;
  final String name;
  Genre(this.id, this.name);
}

class AnimeSearchPage extends StatefulWidget {
  const AnimeSearchPage({super.key});
  static const routeName = '/anime-search';

  @override
  State<AnimeSearchPage> createState() => _AnimeSearchPageState();
}

class _AnimeSearchPageState extends State<AnimeSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<AnimePreview> _searchResults = [];
  List<Genre> _allGenres = [];
  Set<int> _selectedGenreIds = {};

  bool _isLoading = false;
  bool _isFetchingMore = false;
  bool _isSearching = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadGenres();
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
    _loadTopAnime();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _scrollController.removeListener(_onScroll);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadGenres() async {
    try {
      final genres = await fetchGenres();
      final translatedGenres = await Future.wait(
        genres.map((genre) async {
          final translatedName = await translateText(genre.name);
          return Genre(genre.id, translatedName);
        }),
      );
      final Set<String> adultGenreNames = {
        'Hentai',
        'Ecchi',
        'Erótica',
        'Erótico',
      };

      final filteredGenres =
          translatedGenres
              .where((g) => !adultGenreNames.contains(g.name))
              .toList();

      setState(() {
        _allGenres = filteredGenres;
      });
    } catch (e) {
      setState(() {});
    }
  }

  Future<List<Genre>> fetchGenres() async {
    final url = Uri.parse('https://api.jikan.moe/v4/genres/anime');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error al obtener géneros');
    }

    final data = jsonDecode(response.body);
    final List<dynamic> genresJson = data['data'];

    return genresJson.map((genreJson) {
      return Genre(genreJson['mal_id'], genreJson['name']);
    }).toList();
  }

  void _onSearchChanged() {
    if (_searchController.text.trim().isEmpty) {
      _loadTopAnime();
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingMore &&
        !_isLoading) {
      _fetchMore();
    }
  }

  Future<void> _loadTopAnime() async {
    setState(() {
      _isLoading = true;
      _isSearching = false;
      _currentPage = 1;
      _searchResults.clear();
    });

    try {
      final results =
          _selectedGenreIds.isEmpty
              ? await jikanGetTopAnimePreviews(_currentPage)
              : await jikanGetTopAnimeByGenres(
                _currentPage,
                _selectedGenreIds.toList(),
              );

      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar top animes: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _search() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _isSearching = true;
      _currentPage = 1;
      _searchResults.clear();
    });

    try {
      final results = await jikanSearchAnimePreviews(
        query,
        page: _currentPage,
        genres: _selectedGenreIds.toList(),
      );
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al buscar: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchMore() async {
    if (_isFetchingMore) return;

    _isFetchingMore = true;
    _currentPage++;

    try {
      List<AnimePreview> moreResults;
      if (_isSearching) {
        moreResults = await jikanSearchAnimePreviews(
          _searchController.text.trim(),
          page: _currentPage,
          genres: _selectedGenreIds.toList(),
        );
      } else {
        moreResults = await jikanGetTopAnimePreviews(_currentPage);
      }

      setState(() {
        _searchResults.addAll(moreResults);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      _isFetchingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explorar animes')),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (_) => _search(),
                    decoration: InputDecoration(
                      labelText: 'Buscar por nombre',
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _search,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.filter_list),
              label: Text(
                _selectedGenreIds.isEmpty
                    ? 'Filtrar por género'
                    : 'Filtrando: ${_selectedGenreIds.length} géneros',
              ),
              onPressed: () async {
                final selected = await showModalBottomSheet<Set<int>>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return GenreFilterSheet(
                      allGenres: _allGenres,
                      selectedGenres: Set<int>.from(_selectedGenreIds),
                    );
                  },
                );

                if (selected != null) {
                  setState(() {
                    _selectedGenreIds = selected;
                  });

                  if (_searchController.text.trim().isNotEmpty) {
                    _search();
                  } else {
                    _loadTopAnime();
                  }
                }
              },
            ),
          ),

          // Resultados
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _searchResults.isEmpty
                    ? const Center(child: Text('No hay resultados'))
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GridView.builder(
                        controller: _scrollController,
                        itemCount: _searchResults.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              childAspectRatio: 0.6,
                            ),
                        itemBuilder: (context, index) {
                          final anime = _searchResults[index];
                          return PreviewAnimeCard(
                            imageUrl: anime.urlImage,
                            gameName: anime.title,
                            rating: anime.score,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          AnimeInfoPage(animeId: anime.id),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
