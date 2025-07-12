import 'package:data_nime/domain/entities/anime.dart';
import 'package:data_nime/domain/entities/anime_preview.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('anime.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB  (Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
      CREATE TABLE IF NOT EXISTS favoriteAnime (
        id INTEGER PRIMARY KEY,
        title TEXT,
        score REAL,
        urlImage TEXT
      )
    ''');

    batch.execute('''
      CREATE TABLE IF NOT EXISTS watchedAnime (
        id INTEGER PRIMARY KEY,
        title TEXT,
        score REAL,
        urlImage TEXT
      )
    ''');

    batch.execute('''
      CREATE TABLE IF NOT EXISTS pendingAnime (
        id INTEGER PRIMARY KEY,
        title TEXT,
        score REAL,
        urlImage TEXT
      )
    ''');

    await batch.commit();
  }

  Future<void> insertFavoriteAnime({AnimePreview? animePreview, Anime? anime}) async {
    if (animePreview == null && anime == null) return;

    final map = anime != null
      ? {"id": anime.id, "title": anime.title, "score": anime.score, "urlImage": anime.urlImage }
      : animePreview!.toMap();

    final db = await instance.database;
    await db.insert(
      "favoriteAnime",
      map,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> insertPendingAnime({AnimePreview? animePreview, Anime? anime}) async {
    if (animePreview == null && anime == null) return;

    final map = anime != null
      ? {"id": anime.id, "title": anime.title, "score": anime.score, "urlImage": anime.urlImage }
      : animePreview!.toMap();

    final db = await instance.database;
    await db.insert(
      "pendingAnime",
      map,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> insertWatchedAnime({AnimePreview? animePreview, Anime? anime}) async {
    if (animePreview == null && anime == null) return;

    final map = anime != null
      ? {"id": anime.id, "title": anime.title, "score": anime.score, "urlImage": anime.urlImage }
      : animePreview!.toMap();

    final db = await instance.database;
    await db.insert(
      "watchedAnime",
      map,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<AnimePreview>> getFavoriteAnimes() async {
    final db = await instance.database;
    final result = await db.query("favoriteAnime");
    return result.map<AnimePreview>((map) => AnimePreview.fromMap(map)).toList();
  }

  Future<List<AnimePreview>> getPendingAnimes() async {
    final db = await instance.database;
    final result = await db.query("pendingAnime");
    return result.map<AnimePreview>((map) => AnimePreview.fromMap(map)).toList();
  }

  Future<List<AnimePreview>> getWatchedAnimes() async {
    final db = await instance.database;
    final result = await db.query("watchedAnime");
    return result.map<AnimePreview>((map) => AnimePreview.fromMap(map)).toList();
  }

  Future<AnimePreview?> getFavoriteAnime(int id) async {
    final db = await instance.database;
    final result = await db.query("favoriteAnime", where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? AnimePreview.fromMap((result[0])) : null;
  }

  Future<AnimePreview?> getPendingAnime(int id) async {
    final db = await instance.database;
    final result = await db.query("pendingAnime", where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? AnimePreview.fromMap((result[0])) : null;
  }

  Future<AnimePreview?> getWatchedAnime(int id) async {
    final db = await instance.database;
    final result = await db.query("watchedAnime", where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? AnimePreview.fromMap((result[0])) : null;
  }

  Future<void> deleteFavoriteAnime(int id) async {
    final db = await instance.database;
    await db.delete('favoriteAnime', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deletePendingAnime(int id) async {
    final db = await instance.database;
    await db.delete('pendingAnime', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteWatchedAnime(int id) async {
    final db = await instance.database;
    await db.delete('watchedAnime', where: 'id = ?', whereArgs: [id]);
  }

  // Future<void> updateGame(Videojuego juego) async {
  //   final db = await instance.database;
  //   await db.update(
  //     'juegos',
  //     juego.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [juego.id],
  //   );
  // }

  // Future<List<String>> getAllGenres() async {
  //   final db = await instance.database;
  //   final result = await db.rawQuery('SELECT DISTINCT genero FROM juegos');
  //   return result.map((row) => row['genero'] as String).toList();
  // }
}
