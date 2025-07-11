import 'dart:convert';
import 'package:http/http.dart' as http;

class WatchmodeService {
  static const String _apiKey = 'BxbQkeuA4zQhfTBMPPiS3q8NayN67YLpSyluSj6w';
  static const String _baseUrl = 'https://api.watchmode.com/v1';

  static Future<int?> searchAnimeId(String title) async {
    final response = await http.get(
      Uri.parse(
        "$_baseUrl/search/?apiKey=$_apiKey&search_field=name&search_value=$title",
      ),
    );

    if (response.statusCode == 200) {
      final results = jsonDecode(response.body)["title_results"];
      for (var result in results) {
        final resultTitle = (result["name"] as String).toLowerCase();
        if (resultTitle == title.toLowerCase()) {
          return result["id"] as int;
        }
      }

      // Si no encontró exacto, devuelve el primero
      if (results.isNotEmpty) {
        return results[0]["id"] as int;
      }
    }
    return null;
  }

  static Future<List<StreamingPlatform>> getStreamingPlatforms(
    int watchmodeId,
  ) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/title/$watchmodeId/sources/?apiKey=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> sources = jsonDecode(response.body);
      final Map<String, StreamingPlatform> uniquePlatforms = {};

      for (var source in sources) {
        if ((source["type"] == "sub" || source["type"] == "free") &&
            source["web_url"] != null &&
            source["web_url"].toString().isNotEmpty) {
          final name = source["name"] as String;
          final url = source["web_url"] as String;

          if (!uniquePlatforms.containsKey(name)) {
            uniquePlatforms[name] = StreamingPlatform(name: name, url: url);
          }
        }
      }

      return uniquePlatforms.values.toList();
    }

    return [];
  }
}

class StreamingPlatform {
  final String name;
  final String url;

  StreamingPlatform({required this.name, required this.url});
}
