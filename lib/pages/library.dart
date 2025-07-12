import 'package:data_nime/domain/entities/anime_preview.dart';
import 'package:data_nime/pages/anime_info.dart';
import 'package:data_nime/widget/card_preview_anime.dart';
import 'package:flutter/material.dart';
import 'package:data_nime/widget/app_drawer.dart';
import 'package:data_nime/data/services/database_helper.dart';

class LibraryPage extends StatefulWidget {
  static const routeName = '/library';
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<AnimePreview> favoriteAnimes = [];
  List<AnimePreview> watchedAnimes = [];
  List<AnimePreview> pendingAnimes = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    favoriteAnimes = await DatabaseHelper.instance.getFavoriteAnimes();
    pendingAnimes = await DatabaseHelper.instance.getPendingAnimes();
    watchedAnimes = await DatabaseHelper.instance.getWatchedAnimes();

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi Biblioteca'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.favorite), text: "Favoritos"),
              Tab(icon: Icon(Icons.check_box_outlined), text: "Vistos"),
              Tab(icon: Icon(Icons.schedule), text: "Pendientes"),
            ],
          ),
        ),
        drawer: const AppDrawer(),
        body: TabBarView(
          children: [
            _buildGameList(favoriteAnimes),
            _buildGameList(watchedAnimes),
            _buildGameList(pendingAnimes),
          ],
        ),
      ),
    );
  }

  Widget _buildGameList(List<AnimePreview> animePreviews) {
    if (animePreviews.isEmpty) {
      return const Center(child: Text('No hay animes en esta categoría.'));
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 0.6,
      ),
      itemCount: animePreviews.length,
      itemBuilder: (context, index) {
        return PreviewAnimeCard(
          imageUrl: animePreviews[index].urlImage,
          title: animePreviews[index].title,
          rating: animePreviews[index].score,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        AnimeInfoPage(animeId: animePreviews[index].id)
              ),
            );
          },
        );
      },
    );
  }
}
