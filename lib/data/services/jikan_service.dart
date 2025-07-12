import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:data_nime/domain/entities/anime.dart';
import 'package:data_nime/domain/entities/anime_preview.dart';
import 'package:data_nime/domain/entities/character_preview.dart';
import 'package:data_nime/domain/entities/character.dart';

Future<List<dynamic>> jikanGetAllAnimes() async {
  final List<dynamic> allAnimes = [];
  bool hasNextPage = true;
  int currentPage = 1;
  int maxPages = 5; // totalPages=pagination["last_visible_pages"]

  while (hasNextPage && currentPage <= maxPages) {
    final urlAnimePage = Uri.parse(
      "https://api.jikan.moe/v4/anime?page=$currentPage",
    );
    final response = await http.get(urlAnimePage);

    if (response.statusCode != 200) {
      throw Exception(
        "Error al cargar animes de Jikan (status: ${response.statusCode})",
      );
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    final pagination = json["pagination"];
    hasNextPage = pagination["has_next_page"] as bool;

    final List<dynamic> animeList = json["data"];
    allAnimes.addAll(animeList);

    currentPage++;
    await Future.delayed(
      Duration(milliseconds: 500),
    ); // evitar bloqueo de peticiones
  } // while

  return allAnimes;
}

// Future<void> jikanImportAnimes() async {
//   List<dynamic> allAnimes = await jikanGetAllAnimes();
//   DatabaseHelper db = DatabaseHelper.instance;

//   void actionInsertAnime(dynamic anime) async {
//     await db.insertFavoriteAnime(
//       Anime(
//         title: anime["title"] ?? "",
//         titleEnglish: anime["title_english"] ?? "",
//         titleJapanese: anime["title_japanese"] ?? "",
//         titleSpanish:
//             (anime["titles"] as List).firstWhere((title) {
//               return title["type"] == "Spanish";
//             }, orElse: () => {"title": ""})["title"] ??
//             "",
//         synopsis: anime["synopsis"] ?? "",
//         type: anime["type"] ?? "",
//         source: anime["source"] ?? "",
//         episodes: anime["episodes"] ?? 0,
//         status: anime["status"] ?? "",
//         aired: anime["aired"]["string"] ?? "",
//         genres:
//             (anime["genres"] as List).map((genre) {
//               return genre["name"] as String;
//             }).toList(),
//         explicitGenres:
//             (anime["explicit_genres"] as List).map<String>((genre) {
//               return genre["name"] as String;
//             }).toList(),
//         urlImage: anime["images"]["jpg"]["large_image_url"] ?? "",
//         urlTrailer: anime["trailer"]["youtube_id"]?.toString() ?? "",
//       ),
//     );
//   }

//   allAnimes.forEach(actionInsertAnime);
// }

Future<List<AnimePreview>> jikanGetAnimePreviews(int page) async {
  List<AnimePreview> animesPreviews = [];
  final urlAnimePage = Uri.parse("https://api.jikan.moe/v4/anime?page=$page");
  final response = await http.get(urlAnimePage);

  if (response.statusCode != 200) {
    throw Exception(
      "Error al cargar animes de Jikan (status: ${response.statusCode})",
    );
  }

  final Map<String, dynamic> json = jsonDecode(response.body);
  final animes = (json["data"] as List<dynamic>);

  for (var anime in animes) {
    animesPreviews.add(
      AnimePreview(
        id: (anime["mal_id"] as int),
        score: (anime["score"] as num?)?.toDouble() ?? 0.0,
        urlImage: (anime["images"]["jpg"]["large_image_url"] as String),
        title: (anime["title_english"] ?? anime["title"]) as String,
      ),
    );
  }

  await Future.delayed(Duration(milliseconds: 500));

  return animesPreviews;
}

Future<Anime> jikanGetAnimeById(int id) async {
  final url = Uri.parse("https://api.jikan.moe/v4/anime/$id");
  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception(
      "Error al cargar animes de Jikan (status: ${response.statusCode})",
    );
  }

  final Map<String, dynamic> json = jsonDecode(response.body);
  final anime = json["data"];

  return Anime(
    id: anime["mal_id"],
    title: anime["title"] ?? "",
    titleEnglish: anime["title_english"] ?? "",
    titleJapanese: anime["title_japanese"] ?? "",
    titleSpanish:
        (anime["titles"] as List).firstWhere(
          (title) => title["type"] == "Spanish",
          orElse: () => {"title": ""},
        )["title"] ??
        "",
    synopsis: anime["synopsis"] ?? "",
    type: anime["type"] ?? "",
    source: anime["source"] ?? "",
    episodes: anime["episodes"] ?? 0,
    status: anime["status"] ?? "",
    aired: anime["aired"]["string"] ?? "",
    score: (anime["score"] as num?)?.toDouble() ?? 0.0,
    genres:
        (anime["genres"] as List)
            .map((genre) => genre["name"] as String)
            .toList(),
    explicitGenres:
        (anime["explicit_genres"] as List)
            .map<String>((genre) => genre["name"] as String)
            .toList(),
    urlImage: anime["images"]["jpg"]["large_image_url"] ?? "",
    urlTrailer: anime["trailer"]["youtube_id"]?.toString() ?? "",
  );
}

Future<List<CharacterPreview>> jikanGetCharacterPreviewsById(int id) async {
  final url = Uri.parse("https://api.jikan.moe/v4/anime/$id/characters");
  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception(
      "Error al cargar personajes de anime de Jikan (status: ${response.statusCode})",
    );
  }

  final Map<String, dynamic> json = jsonDecode(response.body);
  final characters = json["data"];

  final List<CharacterPreview> characterPreviews = [];

  for (var character in characters) {
    characterPreviews.add(
      CharacterPreview(
        id: character["character"]["mal_id"],
        urlImage: character["character"]["images"]["jpg"]["image_url"] ?? "",
        name: character["character"]["name"] ?? "",
      ),
    );
  }

  return characterPreviews;
}

Future<Character> jikanGetCharacterFullById(int id) async {
  final url = Uri.parse("https://api.jikan.moe/v4/characters/$id/full");
  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception(
      "Error al cargar personajes de anime de Jikan (status: ${response.statusCode})",
    );
  }

  final Map<String, dynamic> json = jsonDecode(response.body);
  final character = json["data"];

  Map<String, String> voices = {};
  for (var voice in (character["voices"] as List)) {
    voices[voice["language"]] = voice["person"]["name"];
  }

  final List<String> nicknames = [];
  for (var nickname in character["nicknames"]) {
    nicknames.add(nickname);
  }

  final Map<int, String> animes = {};
  for (var anime in character["anime"]) {
    if (anime == null || anime["anime"]["mal_id"] == null) continue;
    animes[anime["anime"]["mal_id"]] = anime["anime"]["title"] ?? "";
  }

  return Character(
    id: character["mal_id"],
    name: character["name"] ?? "",
    kanjiName: character["name_kanji"] ?? "",
    about:
        character["about"] == null || (character["about"] as String).isEmpty
            ? "Sin descripción"
            : character["about"],
    urlImage: character["images"]["jpg"]["image_url"] ?? "",
    favorites: character["favorites"],
    nicknames: nicknames,
    animes: animes,
    voices: voices,
  );
}

Future<List<AnimePreview>> jikanGetRecommendationsPreviewByAnime(
  int animeId,
) async {
  final response = await http.get(
    Uri.parse('https://api.jikan.moe/v4/anime/$animeId/recommendations'),
  );

  if (response.statusCode != 200) {
    throw Exception("Error al obtener recomendaciones");
  }

  final data = jsonDecode(response.body);
  final List<dynamic> recommendations = data['data'];

  return recommendations.take(10).map<AnimePreview>((item) {
    final entry = item['entry'];
    return AnimePreview(
      id: entry['mal_id'],
      score: 0.0, // no se carga el score aún para evitar bloqueos
      urlImage: entry['images']['jpg']['large_image_url'],
      title: entry['title'],
    );
  }).toList();
}

Future<List<AnimePreview>> jikanGetTopAnimePreviews(int page) async {
  final response = await http.get(
    Uri.parse('https://api.jikan.moe/v4/top/anime?page=$page&sfw=true'),
  );

  if (response.statusCode != 200) {
    throw Exception("Error al obtener topAnimes");
  }

  final data = jsonDecode(response.body);
  final List<dynamic> topAnimes = data['data'];

  return topAnimes.map<AnimePreview>((anime) {
    return AnimePreview(
      id: (anime["mal_id"] as int),
      score: (anime["score"] as num?)?.toDouble() ?? 0.0,
      urlImage: (anime["images"]["jpg"]["large_image_url"] as String),
      title: (anime["title"] as String),
    );
  }).toList();
}

Future<List<AnimePreview>> jikanGetRandomAnimes(int max) async {
  List<Map<String, dynamic>> datas = [];
  for (int i = 0; i < max; i++) {
    final response = await http.get(
      Uri.parse('https://api.jikan.moe/v4/random/anime'),
    );

    if (response.statusCode != 200) {
      throw Exception("Error al obtener randomAnimes");
    }

    final json = jsonDecode(response.body);
    datas.add(json["data"]);
  }

  final List<AnimePreview> randomAnimes = [];
  for (var anime in datas) {
    if (max <= 0) break;
    max--;
    randomAnimes.add(
      AnimePreview(
        id: (anime["mal_id"] as int),
        score: (anime["score"] as num?)?.toDouble() ?? 0.0,
        urlImage: (anime["images"]["jpg"]["image_url"] as String),
        title: (anime["title"] as String),
      ),
    );
  }

  return randomAnimes;
}

Future<List<AnimePreview>> jikanGetRandomAnimesConcurrent(int count) async {
  List<Future<Map<String, dynamic>?>> futures = [];
  Set<int> fetchedIds = {};

  Future<Map<String, dynamic>?> getSingleRandomAnime() async {
    try {
      final response = await http.get(Uri.parse('https://api.jikan.moe/v4/random/anime'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['data'];
      } else {
        print('Error al obtener anime: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Excepcion al obtener anime: $e');
      return null;
    }
  }

  for (int i = 0; i < count; i++) {
    futures.add(getSingleRandomAnime());
  }

  List<Map<String, dynamic>?> results = await Future.wait(futures);

  List<AnimePreview> randomAnimes = [];
  for (var anime in results) {
    if (anime == null
        || anime['mal_id'] == null
        || fetchedIds.contains(anime['mal_id']))
        {continue;}

    randomAnimes.add(
      AnimePreview(
        id: anime["mal_id"],
        score: (anime["score"] as num?)?.toDouble() ?? 0.0,
        urlImage: (anime["images"]["jpg"]["image_url"] as String),
        title: (anime["title"] as String)
      )
    );
    fetchedIds.add(anime['mal_id']);
  }

  return randomAnimes;
}

Future<List<CharacterPreview>> jikanGetTopCharacterPreviews(int page) async {
  final response = await http.get(
    Uri.parse('https://api.jikan.moe/v4/top/characters?page=$page'),
  );

  if (response.statusCode != 200) {
    throw Exception("Error al obtener topCharacters");
  }

  final data = jsonDecode(response.body);
  final List<dynamic> topCharacters = data['data'];

  return topCharacters.map<CharacterPreview>((character) {
    return CharacterPreview(
      id: character["mal_id"],
      urlImage: character["images"]["jpg"]["image_url"] ?? "",
      name: character["name"] ?? "",
    );
  }).toList();
}

Future<List<String>> jikanGetCharacterImageUrls(int id) async {
  final response = await http.get(
    Uri.parse('https://api.jikan.moe/v4/characters/$id/pictures'),
  );

  if (response.statusCode != 200) {
    throw Exception("Error al obtener topCharacters");
  }

  final data = jsonDecode(response.body);
  final List<dynamic> images = data['data'];

  return images.map<String>((image) {
    return image["jpg"]["image_url"] ?? "";
  }).toList();
}

Future<List<AnimePreview>> jikanSearchAnimePreviews(
  String query, {
  int page = 1,
  List<int>? genres,
}) async {
  final genresParam =
      genres != null && genres.isNotEmpty ? '&genres=${genres.join(",")}' : '';
  final url = Uri.parse(
    "https://api.jikan.moe/v4/anime?q=$query&page=$page&order_by=score&sort=desc$genresParam&sfw=true",
  );
  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception("Error al buscar animes");
  }

  final Map<String, dynamic> json = jsonDecode(response.body);
  final animes = json["data"] as List<dynamic>;

  return animes.map((anime) {
    return AnimePreview(
      id: anime["mal_id"],
      score: (anime["score"] as num?)?.toDouble() ?? 0.0,
      urlImage: anime["images"]["jpg"]["large_image_url"] as String,
      title: anime["title_english"] ?? anime["title"],
    );
  }).toList();
}

Future<List<AnimePreview>> jikanGetTopAnimeByGenres(
  int page,
  List<int>? genres,
) async {
  final genresParam =
      genres != null && genres.isNotEmpty ? '&genres=${genres.join(",")}' : '';
  final url = Uri.parse(
    'https://api.jikan.moe/v4/anime?order_by=score&sort=desc&page=$page$genresParam&sfw=true',
  );
  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception('Error al obtener top animes filtrados');
  }

  final data = jsonDecode(response.body);
  final List<dynamic> animes = data['data'];

  return animes.map<AnimePreview>((anime) {
    return AnimePreview(
      id: anime['mal_id'],
      score: (anime['score'] as num?)?.toDouble() ?? 0.0,
      urlImage: anime['images']['jpg']['large_image_url'] as String,
      title: anime['title'],
    );
  }).toList();
}
