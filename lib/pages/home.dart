import 'package:data_nime/pages/animes.dart';
import 'package:data_nime/pages/character_info.dart';
import 'package:data_nime/pages/characters.dart';
import 'package:data_nime/widget/card_preview_character.dart';
import 'package:flutter/material.dart';
import 'package:data_nime/widget/app_drawer.dart';
import 'package:data_nime/data/services/jikan_service.dart';
import 'package:data_nime/widget/card_preview_anime.dart';
import 'package:data_nime/widget/horizontal_card_list.dart';
import 'package:data_nime/widget/section_header.dart';
import 'package:data_nime/pages/anime_info.dart';
import 'package:data_nime/domain/entities/anime_preview.dart';
import 'package:data_nime/domain/entities/character_preview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  static const routeName = '/home';
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<AnimePreview> _topAnimes = [];
  late List<AnimePreview> _randomAnimes = [];
  late List<CharacterPreview> _topCharacters = [];
  bool _waitingForRandomAnime = false;

  @override
  void initState() {
    super.initState();
    _loadAnimes();
  }

  Future<void> _loadAnimes() async {
    _topAnimes = await jikanGetTopAnimePreviews(1);
    _topCharacters = await jikanGetTopCharacterPreviews(1);
    jikanGetRandomAnimesConcurrent(10).then((randomAnimes) {
      _randomAnimes = randomAnimes;
      setState(() {});
    });

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SectionHeader(
                title: "Mejores Animes",
                onSeeMorePressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnimePage()),
                  );
                },
              ),
            ),
            HorizontalCardList(
              itemCount: _topAnimes.length,
              itemBuilder: (context, index) {
                return PreviewAnimeCard(
                  imageUrl: _topAnimes[index].urlImage,
                  title: _topAnimes[index].title,
                  rating: _topAnimes[index].score,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                AnimeInfoPage(animeId: _topAnimes[index].id),
                      ),
                    );
                  },
                );
              },
            ),

            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SectionHeader(
                title: "Mejores Personajes",
                onSeeMorePressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CharacterPage()),
                  );
                },
              ),
            ),
            HorizontalCardList(
              itemCount: _topCharacters.length,
              itemBuilder: (context, index) {
                return PreviewCharacterCard(
                  characterName: _topCharacters[index].name,
                  imageUrl: _topCharacters[index].urlImage,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CharacterInfoPage(
                              characterId: _topCharacters[index].id,
                            ),
                      ),
                    );
                  },
                );
              },
            ),

            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SectionHeader(
                title: "Animes Random",
                button: const Icon(Icons.refresh),
                onSeeMorePressed: () async {
                  if (_waitingForRandomAnime) return;
                  setState(() {
                    _waitingForRandomAnime = true;
                  });
                  _randomAnimes = await jikanGetRandomAnimesConcurrent(10);
                  setState(() {
                    _waitingForRandomAnime = false;
                  });
                }
              ),
            ),
            if (_waitingForRandomAnime)
              Center(heightFactor: 7, child: CircularProgressIndicator())
            else
              HorizontalCardList(
                itemCount: _randomAnimes.length,
                itemBuilder: (context, index) {
                  return PreviewAnimeCard(
                    imageUrl: _randomAnimes[index].urlImage,
                    title: _randomAnimes[index].title,
                    rating: _randomAnimes[index].score,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  AnimeInfoPage(animeId: _randomAnimes[index].id),
                        ),
                      );
                    },
                  );
                },
              ),
            SizedBox(height: 32),
          ],
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
