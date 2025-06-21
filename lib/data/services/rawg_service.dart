import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:videogame_rating/domain/entities/videogame.dart';
import 'package:videogame_rating/domain/entities/genre_translations.dart';

class RawgService {
  final String _apiKey = 'eb23da9e656e4b40a1014b96087bfdd6'; // Tu API Key

  Future<List<Videojuego>> fetchPopularGames({int total = 1000}) async {
    final List<Videojuego> allGames = [];
    final int pageSize = 40;
    final int totalPages = (total / pageSize).ceil();

    for (int page = 1; page <= totalPages; page++) {
      final url = Uri.parse(
        'https://api.rawg.io/api/games?key=$_apiKey&page=$page&page_size=$pageSize',
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> games = data['results'];

        allGames.addAll(
          games.map((json) {
            List<String> generos = [];
            if (json['genres'] != null) {
              generos =
                  (json['genres'] as List)
                      .map((g) => g['name'] as String)
                      .toList();
            }
            generos = translateGenres(generos);
            return Videojuego(
              id: null,
              nombre: json['name'] ?? 'Nombre desconocido',
              genero: generos,
              calificacion: (json['rating'] as num).toDouble(),
              plataformas:
                  (json['platforms'] as List)
                      .map((p) => p['platform']['name'] as String)
                      .toList(),
              anio: DateTime.tryParse(json['released'] ?? '')?.year ?? 2000,
              imagenUrl: json['background_image'] ?? '',
            );
          }).toList(),
        );
      } else {
        throw Exception(
          'Error al cargar los videojuegos de RAWG (status ${response.statusCode})',
        );
      }
    }

    return allGames;
  }
}
