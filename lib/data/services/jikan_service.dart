import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> jikanGetAllAnimes() async {
  bool hasNextPage = true;
  int currentPage = 1;
  // int maxPages = 3;

  while (hasNextPage /*&& currentPage <= maxPages*/) {
    final urlAnimePage = Uri.parse("https://api.jikan.moe/v4/anime?page=$currentPage");
    final response = await http.get(urlAnimePage);

    if (response.statusCode != 200) {
      throw Exception("Error al cargar animes de Jikan (status: ${response.statusCode})");
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    final pagination = json["pagination"];
    hasNextPage = pagination["has_next_page"] as bool;

    final List<dynamic> animeList = json["data"];

    for (final anime in animeList) {
      final title = anime["titles"][0]["title"];
      final id = anime["mal_id"];
      print("[$id] $title");
    }

    currentPage++;
    await Future.delayed(Duration(milliseconds: 500)); // evitar bloqueo de peticiones
  } // while
}