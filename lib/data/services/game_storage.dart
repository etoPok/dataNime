import 'package:shared_preferences/shared_preferences.dart';

class GameStorage {
  static const String favoriteKey = 'favorite_games';
  static const String savedKey = 'saved_games';
  static const String playedKey = 'played_games';

  static Future<void> toggleGame(String key, String gameName) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> games = prefs.getStringList(key) ?? [];

    if (games.contains(gameName)) {
      games.remove(gameName);
    } else {
      games.add(gameName);
    }

    await prefs.setStringList(key, games);
  }

  static Future<List<String>> getGames(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  static Future<bool> isGameStored(String key, String gameName) async {
    final prefs = await SharedPreferences.getInstance();
    final games = prefs.getStringList(key) ?? [];
    return games.contains(gameName);
  }
}
