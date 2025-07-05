import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:data_nime/domain/entities/anime.dart';
import 'package:data_nime/domain/entities/anime_preview.dart';
import 'package:data_nime/data/services/database_helper.dart';

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

Future<void> jikanImportAnimes() async {
  List<dynamic> allAnimes = await jikanGetAllAnimes();
  DatabaseHelper db = DatabaseHelper.instance;

  void actionInsertAnime(dynamic anime) async {
    await db.insertAnime(
      Anime(
        title: anime["title"] ?? "",
        titleEnglish: anime["title_english"] ?? "",
        titleJapanese: anime["title_japanese"] ?? "",
        titleSpanish:
            (anime["titles"] as List).firstWhere((title) {
              return title["type"] == "Spanish";
            }, orElse: () => {"title": ""})["title"] ??
            "",
        synopsis: anime["synopsis"] ?? "",
        type: anime["type"] ?? "",
        source: anime["source"] ?? "",
        episodes: anime["episodes"] ?? 0,
        status: anime["status"] ?? "",
        aired: anime["aired"]["string"] ?? "",
        genres:
            (anime["genres"] as List).map((genre) {
              return genre["name"] as String;
            }).toList(),
        explicitGenres:
            (anime["explicit_genres"] as List).map<String>((genre) {
              return genre["name"] as String;
            }).toList(),
      ),
    );
  }

  allAnimes.forEach(actionInsertAnime);
}

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
        score: (anime["score"] as double),
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
    genres:
        (anime["genres"] as List)
            .map((genre) => genre["name"] as String)
            .toList(),
    explicitGenres:
        (anime["explicit_genres"] as List)
            .map<String>((genre) => genre["name"] as String)
            .toList(),
  );
}
