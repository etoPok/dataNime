import 'package:flutter/material.dart';
import 'package:data_nime/data/services/jikan_service.dart';
import 'package:data_nime/domain/entities/anime.dart';
import 'package:data_nime/utils/google_translator.dart';
import 'package:data_nime/widget/anime_trailer.dart';

class AnimeInfoPage extends StatefulWidget {
  final int animeId;

  const AnimeInfoPage({super.key, required this.animeId});

  @override
  State<AnimeInfoPage> createState() => _AnimeInfoPageState();
}

class _AnimeInfoPageState extends State<AnimeInfoPage> {
  late Future<Anime> futureAnime;
  String translatedSynopsis = "";

  @override
  void initState() {
    super.initState();
    futureAnime = jikanGetAnimeById(widget.animeId);
    futureAnime = jikanGetAnimeById(widget.animeId).then((anime) async {
      return await translateAnime(anime);
    });
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
                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }
}
