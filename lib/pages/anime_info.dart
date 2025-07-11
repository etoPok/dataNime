import 'package:data_nime/pages/character_info.dart';
import 'package:data_nime/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:data_nime/data/services/jikan_service.dart';
import 'package:data_nime/domain/entities/anime.dart';
import 'package:data_nime/utils/google_translator.dart';
import 'package:data_nime/widget/anime_trailer.dart';
import 'package:data_nime/widget/card_preview_character.dart';
import 'package:data_nime/domain/entities/character_preview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:data_nime/domain/entities/character.dart';
import 'package:data_nime/domain/entities/anime_preview.dart';
import 'package:data_nime/widget/card_preview_anime.dart';
import 'package:data_nime/widget/app_drawer.dart';
import 'package:data_nime/data/services/watchmode_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimeInfoPage extends StatefulWidget {
  final int animeId;

  const AnimeInfoPage({super.key, required this.animeId});

  @override
  State<AnimeInfoPage> createState() => _AnimeInfoPageState();
}

class _AnimeInfoPageState extends State<AnimeInfoPage> {
  late Future<Anime> futureAnime;
  late Future<List<AnimePreview>> futureRecommendations;
  String translatedSynopsis = "";
  late List<CharacterPreview> characterPreviews;
  final List<CharacterPreview?> _positionBackup = List.filled(3, null);
  int? _expandCharacterIndex;
  int _indexToExpand = 0;
  int _visibleCharacterCount = 20;
  List<StreamingPlatform> streamingPlatforms = [];

  @override
  void initState() {
    super.initState();
    futureAnime = jikanGetAnimeById(widget.animeId).then((anime) async {
      characterPreviews = await jikanGetCharacterPreviewsById(widget.animeId);

      final titleToSearch =
          anime.titleEnglish.isNotEmpty ? anime.titleEnglish : anime.title;
      final watchmodeId = await WatchmodeService.searchAnimeId(titleToSearch);

      if (watchmodeId != null) {
        streamingPlatforms = await WatchmodeService.getStreamingPlatforms(
          watchmodeId,
        );
      }

      return await translateAnime(anime);
    });
    futureRecommendations = jikanGetRecommendationsPreviewByAnime(widget.animeId);
  }

  void _swapCharacterPreviews(int index1, int index2) {
    CharacterPreview character = characterPreviews[index1];
    characterPreviews[index1] = characterPreviews[index2];
    characterPreviews[index2] = character;
  }

  void _restoreCharacterPreviews() {
    for (
      int i = 0;
      _indexToExpand + i < characterPreviews.length && i < 3;
      i++
    ) {
      characterPreviews[_indexToExpand + i] = _positionBackup[i]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Información del Anime",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder<Anime>(
        future: futureAnime,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final anime = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Volver"),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        anime.urlImage,
                        width: 150,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            anime.titleEnglish.isNotEmpty
                                ? anime.titleEnglish
                                : anime.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Título japonés: ${anime.titleJapanese}"),
                          Text("Tipo: ${anime.type}"),
                          Text("Episodios: ${anime.episodes}"),
                          Text("Estado: ${anime.status}"),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                if (anime.urlTrailer.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tráiler",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimeTrailerPlayer(youtubeId: anime.urlTrailer),
                      const SizedBox(height: 20),
                    ],
                  )
                else
                  const Text("Tráiler no disponible."),

                // Géneros
                const Text(
                  "Géneros",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  children:
                      anime.genres
                          .map((genre) => Chip(label: Text(genre)))
                          .toList(),
                ),
                const SizedBox(height: 20),

                // Sinopsis traducida
                const Text(
                  "Sinopsis",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(anime.synopsis),
                const SizedBox(height: 20),

                //Plataformas
                const Text(
                  "Plataformas",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  children:
                      streamingPlatforms
                          .map(
                            (platform) => ActionChip(
                              label: Text(platform.name),
                              avatar: Icon(Icons.open_in_new, size: 18),
                              onPressed: () async {
                                final url = Uri.parse(platform.url);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Abierto en ${platform.name}",
                                      ),
                                    ),
                                  );
                                } else {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "No se pudo abrir ${platform.name}",
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 20),

                // Otros detalles
                const Text(
                  "Detalles",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text("Fuente: ${anime.source}"),
                Text("Emitido: ${anime.aired}"),

                const SizedBox(height: 20),

                //Recomendaciones
                const Text(
                  "Recomendaciones",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<AnimePreview>>(
                  future: futureRecommendations,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Text(
                        "No se pudieron cargar recomendaciones.",
                      );
                    }

                    final recommendations = snapshot.data ?? [];

                    if (recommendations.isEmpty) {
                      return const Text("No hay recomendaciones disponibles.");
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            recommendations.map((anime) {
                              return Container(
                                width: 140,
                                margin: const EdgeInsets.only(right: 12.0),
                                child: PreviewAnimeCard(
                                  imageUrl: anime.urlImage,
                                  gameName: anime.title,
                                  rating:
                                      anime
                                          .score, // es 0.0 por ahora, evitar saturar
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => AnimeInfoPage(
                                              animeId: anime.id,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // Personajes
                const Text(
                  "Personajes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                StaggeredGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: List.generate(
                    _visibleCharacterCount.clamp(0, characterPreviews.length),
                    (index) {
                      CharacterPreview character = characterPreviews[index];

                      if (_expandCharacterIndex != null &&
                          _indexToExpand == index) {
                        character = characterPreviews[_indexToExpand];
                        final Future<Character> futureCharacter =
                            jikanGetCharacterFullById(character.id).then((
                              value,
                            ) async {
                              return await translateCharacter(value);
                            });

                        return StaggeredGridTile.count(
                          crossAxisCellCount: 3,
                          mainAxisCellCount: 3.5,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _expandCharacterIndex = null;
                                _restoreCharacterPreviews();
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FutureBuilder(
                                future: futureCharacter,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text("Error: ${snapshot.error}"),
                                    );
                                  }

                                  final characterFull = snapshot.data!;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SectionHeader(
                                          title: characterFull.name,
                                          onSeeMorePressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                  CharacterInfoPage(characterId: characterFull.id, characterFull: characterFull)
                                              )
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                character.urlImage,
                                                width: 120,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                maxHeight: 200,
                                                maxWidth: 200,
                                              ),
                                              child: SingleChildScrollView(
                                                padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                ),
                                                child: Text(
                                                  characterFull.about,
                                                  style: const TextStyle(
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              "Siyuus",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Japones: ${characterFull.voices["Japanese"] ?? "desconocido"}",
                                            ),
                                            Text(
                                              "Ingles: ${characterFull.voices["English"] ?? "desconocido"}",
                                            ),
                                            Text(
                                              "Español: ${characterFull.voices["Spanish"] ?? "desconocido"}",
                                            ),
                                            Text(
                                              "Coreano: ${characterFull.voices["Korean"] ?? "desconocido"}",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }

                      return StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1.6,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_expandCharacterIndex != null) {
                                _restoreCharacterPreviews();
                              }
                              _expandCharacterIndex = index;
                              _indexToExpand = (index ~/ 3) * 3;

                              for (
                                int i = 0;
                                _indexToExpand + i < characterPreviews.length &&
                                    i < 3;
                                i++
                              ) {
                                _positionBackup[i] =
                                    characterPreviews[_indexToExpand + i];
                              }

                              if (_expandCharacterIndex! % 3 == 0) return;

                              // [a] [b] [x] --> [x] [a] [b]
                              // [a] [x] [c] --> [x] [a] [c]

                              // comprobar si el presionado esta al final de la fila
                              if ((_expandCharacterIndex! + 1) % 3 != 0) {
                                // personaje izquierdo del presionado se mueve al final de la fila
                                _swapCharacterPreviews(
                                  _expandCharacterIndex! - 1,
                                  _expandCharacterIndex!,
                                );
                                // personaje presionado pasa al inicio de la fila (_indexToExpand)
                                _swapCharacterPreviews(
                                  _expandCharacterIndex! - 1,
                                  _indexToExpand,
                                );
                              } else {
                                // personaje presionado pasa al inicio de la fila (_indexToExpand)
                                _swapCharacterPreviews(
                                  _indexToExpand,
                                  _expandCharacterIndex!,
                                );
                              }
                            });
                          },
                          child: PreviewCharacterCard(
                            imageUrl: character.urlImage,
                            characterName: character.name,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (_visibleCharacterCount < characterPreviews.length)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _visibleCharacterCount = (_visibleCharacterCount + 20)
                              .clamp(0, characterPreviews.length);
                        });
                      },
                      child: const Text(
                        "Cargar más personajes",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),

      //Drawer
      drawer: const AppDrawer(),
    );
  }
}
