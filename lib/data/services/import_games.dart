import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:videogame_rating/domain/entities/videogame.dart';
import 'package:videogame_rating/data/services/database_helper.dart';

Future<void> importGamesFromJson() async {
  final String jsonString = await rootBundle.loadString(
    'assets/data/games.json',
  );
  final List<dynamic> jsonList = json.decode(jsonString);

  final db = DatabaseHelper.instance;

  for (var jsonItem in jsonList) {
    final videojuego = Videojuego(
      nombre: jsonItem['nombre'],
      genero: jsonItem['genero'],
      calificacion: (jsonItem['calificacion'] as num).toDouble(),
      plataformas: List<String>.from(jsonItem['plataformas']),
      anio: jsonItem['anio'],
      imagenUrl: jsonItem['imagenUrl'],
    );

    // Verificamos si ya existe por nombre
    final exists = await _gameExistsByName(videojuego.nombre);
    if (!exists) {
      await db.insertGame(videojuego);
    }
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
