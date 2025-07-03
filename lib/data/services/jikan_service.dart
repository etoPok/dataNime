import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:data_nime/domain/entities/anime.dart';
import 'package:data_nime/data/services/database_helper.dart';

Future<List<dynamic>> jikanGetAllAnimes() async {
  final List<dynamic> allAnimes = [];
  bool hasNextPage = true;
  int currentPage = 1;
  int maxPages = 5; // totalPages=pagination["last_visible_pages"]

  while (hasNextPage && currentPage <= maxPages) {
    final urlAnimePage = Uri.parse("https://api.jikan.moe/v4/anime?page=$currentPage");
    final response = await http.get(urlAnimePage);

    if (response.statusCode != 200) {
      throw Exception("Error al cargar animes de Jikan (status: ${response.statusCode})");
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    final pagination = json["pagination"];
    hasNextPage = pagination["has_next_page"] as bool;

    final List<dynamic> animeList = json["data"];
    allAnimes.addAll(animeList);

    currentPage++;
    await Future.delayed(Duration(milliseconds: 500)); // evitar bloqueo de peticiones
  } // while

  return allAnimes;
}

Future<void> jikanImportAnimes() async {
  List<dynamic> allAnimes = await jikanGetAllAnimes();
  DatabaseHelper db = DatabaseHelper.instance;

  void actionInsertAnime(dynamic anime) async {
    await db.insertAnime(Anime(
      title: anime["title"] ?? "",
      titleEnglish: anime["title_english"] ?? "",
      titleJapanese: anime["title_japanese"] ?? "",
      titleSpanish: (anime["titles"] as List)
        .firstWhere((title) { return title["type"] == "Spanish"; }
        , orElse: () => {"title":""})["title"] ?? "",
      synopsis: anime["synopsis"] ?? "",
      type: anime["type"] ?? "",
      source: anime["source"] ?? "",
      episodes: anime["episodes"] ?? 0,
      status: anime["status"] ?? "",
      aired: anime["aired"]["string"] ?? "",
      genres: (anime["genres"] as List)
        .map((genre) { return genre["name"] as String; }).toList(),
      explicitGenres: (anime["explicit_genres"] as List)
        .map<String>((genre) { return genre["name"] as String; }).toList()
    ));
  }

  allAnimes.forEach(actionInsertAnime);
}