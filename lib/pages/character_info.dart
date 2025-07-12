import 'package:data_nime/data/services/jikan_service.dart';
import 'package:data_nime/domain/entities/character.dart';
import 'package:data_nime/utils/google_translator.dart';
import 'package:flutter/material.dart';

class CharacterInfoPage extends StatefulWidget {
  final int characterId;
  final Character? characterFull;

  const CharacterInfoPage({super.key, required this.characterId, this.characterFull});

  @override
  State<CharacterInfoPage> createState() => _CharacterInfoPageState();
}

class _CharacterInfoPageState extends State<CharacterInfoPage> {
  late Future<Character> _futureCharacter;
  late List<String> _characterImages = [];

  @override
  void initState() {
    super.initState();
    _futureCharacter = jikanGetCharacterFullById(widget.characterId).then((character) async {
        _characterImages = await jikanGetCharacterImageUrls(widget.characterId);
        return await translateCharacter(character);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Información del Personaje",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder<Character>(
        future: _futureCharacter,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final character = snapshot.data!;
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
                        character.urlImage,
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
                            character.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Nombre kanji: ${character.kanjiName}"),
                          Text("Favoritos: ${character.favorites}"),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Sobre el personaje",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(character.about),

                const SizedBox(height: 20),
                const Text(
                  "Nicknames",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(character.nicknames.isEmpty ? "Sin nicknames" : character.nicknames.join(", ")),

                const SizedBox(height: 20),
                const Text(
                  "Seiyuus",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text("Japonés: ${character.voices["Japanese"] ?? "desconocido"}"),
                Text("Ingles: ${character.voices["English"] ?? "desconocido"}"),
                Text("Español: ${character.voices["Spanish"] ?? "desconocido"}"),
                Text("Coreano: ${character.voices["Korean"] ?? "desconocido"}"),

                const SizedBox(height: 20),
                const Text(
                  "Animes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(character.animeTitle.join(", ")),

                const SizedBox(height: 20),
                const Text(
                  "Imágenes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 400,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: _characterImages.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        _characterImages[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text('Imagen no disponible'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ]
            )
          );
        },
      ),
    );
  }
}
