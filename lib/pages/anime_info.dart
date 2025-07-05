import 'package:flutter/material.dart';
import 'package:data_nime/data/services/jikan_service.dart';
import 'package:data_nime/domain/entities/anime.dart';
import 'package:data_nime/utils/google_translator.dart';

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
                Text(
                  anime.titleEnglish.isNotEmpty
                      ? anime.titleEnglish
                      : anime.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text("Título en inglés: ${anime.titleEnglish}"),
                Text("Título en japonés: ${anime.titleJapanese}"),
                Text("Tipo: ${anime.type}"),
                Text("Fuente: ${anime.source}"),
                Text("Episodios: ${anime.episodes}"),
                Text("Estado: ${anime.status}"),
                Text("Emitido: ${anime.aired}"),
                const SizedBox(height: 12),
                Text("Géneros: ${anime.genres.join(', ')}"),
                const SizedBox(height: 12),
                Text("Sinopsis:\n${anime.synopsis}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
