import 'package:flutter/material.dart';
import 'package:data_nime/data/services/jikan_service.dart';
import 'package:data_nime/domain/entities/anime.dart';
import 'package:data_nime/utils/google_translator.dart';
import 'package:data_nime/widget/anime_trailer.dart';
import 'package:data_nime/widget/card_preview_character.dart';
import 'package:data_nime/domain/entities/character_preview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:data_nime/domain/entities/character.dart';

class AnimeInfoPage extends StatefulWidget {
  final int animeId;

  const AnimeInfoPage({super.key, required this.animeId});

  @override
  State<AnimeInfoPage> createState() => _AnimeInfoPageState();
}

class _AnimeInfoPageState extends State<AnimeInfoPage> {
  late Future<Anime> futureAnime;
  String translatedSynopsis = "";
  late List<CharacterPreview> characterPreviews;
  final List<CharacterPreview?> _positionBackup = List.filled(3, null);
  int? _expandCharacterIndex;
  int _indexToExpand = 0;
  int _visibleCharacterCount = 20;

  @override
  void initState() {
    super.initState();
    futureAnime = jikanGetAnimeById(widget.animeId).then((anime) async {
      characterPreviews = await jikanGetCharacterPreviewsById(widget.animeId);
      return await translateAnime(anime);
    });
  }

  void _swapCharacterPreviews(int index1, int index2) {
    CharacterPreview character = characterPreviews[index1];
    characterPreviews[index1] = characterPreviews[index2];
    characterPreviews[index2] = character;
  }

  void _restoreCharacterPreviews() {
    for (int i=0; _indexToExpand+i < characterPreviews.length && i < 3; i++) {
      characterPreviews[_indexToExpand+i] = _positionBackup[i]!;
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

                // Otros detalles
                const Text(
                  "Detalles",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text("Fuente: ${anime.source}"),
                Text("Emitido: ${anime.aired}"),

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
                  children: List.generate(_visibleCharacterCount.clamp(0, characterPreviews.length), (index) {
                    CharacterPreview character = characterPreviews[index];

                    if (_expandCharacterIndex != null && _indexToExpand == index) {
                      character = characterPreviews[_indexToExpand];
                      final Future<Character> futureCharacter = jikanGetCharacterFullById(character.id)
                        .then((value) async {
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
                            color: Colors.blueGrey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FutureBuilder(
                              future: futureCharacter,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text("Error: ${snapshot.error}"));
                                }

                                final characterFull = snapshot.data!;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        characterFull.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              character.urlImage,
                                              width: 120,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                                            child: SingleChildScrollView(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                characterFull.about,
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ]
                                      ),
                                      SizedBox(height: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text(
                                            "Siyuus",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                            )
                                          ),
                                          Text(
                                            "Japones: ${characterFull.voices["Japanese"] ?? "desconocido"}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "Ingles: ${characterFull.voices["English"] ?? "desconocido"}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "Español: ${characterFull.voices["Spanish"] ?? "desconocido"}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "Coreano: ${characterFull.voices["Korean"] ?? "desconocido"}",
                                            style: TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }
                            )
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
                            if (_expandCharacterIndex != null) _restoreCharacterPreviews();

                            _expandCharacterIndex = index;
                            _indexToExpand = (index ~/ 3)*3;

                            for (int i=0; _indexToExpand+i < characterPreviews.length && i < 3; i++) {
                              _positionBackup[i] = characterPreviews[_indexToExpand+i];
                            }

                            if (_expandCharacterIndex!%3 == 0) return;

                            // [a] [b] [x] --> [x] [a] [b]
                            // [a] [x] [c] --> [x] [a] [c]

                            // comprobar si el presionado esta al final de la fila
                            if ((_expandCharacterIndex!+1)%3 != 0) {
                              // personaje izquierdo del presionado se mueve al final de la fila
                              _swapCharacterPreviews(_expandCharacterIndex!-1, _expandCharacterIndex!);
                              // personaje presionado pasa al inicio de la fila (_indexToExpand)
                              _swapCharacterPreviews(_expandCharacterIndex!-1, _indexToExpand);
                            } else {
                              // personaje presionado pasa al inicio de la fila (_indexToExpand)
                              _swapCharacterPreviews(_indexToExpand, _expandCharacterIndex!);
                            }
                          });
                        },
                        child: PreviewCharacterCard(
                          imageUrl: character.urlImage,
                          characterName: character.name,
                        ),
                      ),
                    );
                  }),
                ),
                if (_visibleCharacterCount < characterPreviews.length)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _visibleCharacterCount = (_visibleCharacterCount + 20).clamp(0, characterPreviews.length);
                        });
                      },
                      child: const Text(
                        "Cargar más personajes",
                        style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                      ),
                    )
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}