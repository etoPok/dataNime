import 'package:videogame_rating/domain/entities/videogame.dart';
import 'package:videogame_rating/data/services/database_helper.dart';
import 'package:videogame_rating/data/services/rawg_service.dart';

Future<void> importGamesFromApi() async {
  final rawgService = RawgService();
  final db = DatabaseHelper.instance;

  try {
    final List<Videojuego> gamesFromApi = await rawgService.fetchPopularGames();

    for (var game in gamesFromApi) {
      final exists = await _gameExistsByName(game.nombre);
      if (!exists) {
        await db.insertGame(game);
      }
    }
  } catch (e) {
    throw Exception("Error al importar juegos desde RAWG: $e");
  }
}

Future<bool> _gameExistsByName(String name) async {
  final db = await DatabaseHelper.instance.database;
  final result = await db.query(
    'juegos',
    where: 'LOWER(nombre) = ?',
    whereArgs: [name.toLowerCase()],
  );
  return result.isNotEmpty;
}
