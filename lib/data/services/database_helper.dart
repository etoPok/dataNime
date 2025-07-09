import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:data_nime/domain/entities/videogame.dart';
import 'package:data_nime/domain/entities/anime.dart';

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

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB  (Database db, int version) async {
    await db.execute('''
    CREATE TABLE anime (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      titleEnglish TEXT,
      titleJapanese TEXT,
      titleSpanish TEXT,
      synopsis TEXT,
      type TEXT,
      source TEXT,
      episodes INTEGER,
      status TEXT,
      aired TEXT,
      genres TEXT,
      explicitGenres TEXT,
      urlImage TEXT,
      urlTrailer TEXT
    )
    ''');
  }

  Future<Anime> insertAnime(Anime anime) async {
    final db = await instance.database;
    final id = await db.insert(
      "anime",
      anime.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );

    return anime.copyWith(id: id);
  }

  Future<List<Anime>> getAllAnimes() async {
    final db = await instance.database;
    final result = await db.query("anime");
    return result.map((map) => Anime.fromMap(map)).toList();
  }

  Future<void> deleteAnimes() async {
    final db = await instance.database;
    await db.delete("anime");
  }

  Future<void> insertGame(Videojuego juego) async {
    final db = await instance.database;
    await db.insert(
      'juegos',
      juego.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Videojuego>> getAllGames() async {
    final db = await instance.database;
    final result = await db.query('juegos');
    return result.map((map) => Videojuego.fromMap(map)).toList();
  }

  Future<void> updateGame(Videojuego juego) async {
    final db = await instance.database;
    await db.update(
      'juegos',
      juego.toMap(),
      where: 'id = ?',
      whereArgs: [juego.id],
    );
  }

  Future<void> deleteGame(int id) async {
    final db = await instance.database;
    await db.delete('juegos', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<String>> getAllGenres() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT DISTINCT genero FROM juegos');
    return result.map((row) => row['genero'] as String).toList();
  }
}
