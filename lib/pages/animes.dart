import 'package:data_nime/data/services/jikan_service.dart';
import 'package:data_nime/domain/entities/anime_preview.dart';
import 'package:data_nime/pages/anime_info.dart';
import 'package:data_nime/widget/card_preview_anime.dart';
import 'package:flutter/material.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});
  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  int _currentPage = 1;
  List<AnimePreview> animes = [];
  bool requestInProgress = false;

  @override
  void initState() {
    super.initState();
    _loadAnimes();
  }

  void _loadAnimes() async {
    animes = await jikanGetAnimePreviews(_currentPage);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animes")),
      body: !requestInProgress ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 0.6,
        ),
        itemCount: animes.length,
        itemBuilder: (context, index) {
          return PreviewAnimeCard(
            imageUrl: animes[index].urlImage,
            title: animes[index].title,
            rating: animes[index].score,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          AnimeInfoPage(animeId: animes[index].id),
                ),
              );
            },
          );
        },
      ) : Center(child: CircularProgressIndicator()),
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () async {
                if (requestInProgress || _currentPage <= 1) return;
                setState(() {
                  _currentPage--;
                  requestInProgress = true;
                });
                animes = await jikanGetAnimePreviews(_currentPage);
                setState(() {
                  requestInProgress = false;
                });
              },
            ),
            Text("$_currentPage"),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (requestInProgress) return;
                setState(() {
                  _currentPage++;
                  requestInProgress = true;
                });
                animes = await jikanGetAnimePreviews(_currentPage);
                setState(() {
                  requestInProgress = false;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
