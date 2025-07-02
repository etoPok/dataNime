import 'package:flutter/material.dart';
import 'package:data_nime/widget/app_drawer.dart';
import 'package:data_nime/widget/card_videogame.dart';
import 'package:data_nime/domain/entities/videogame.dart';
import 'package:data_nime/data/services/database_helper.dart';
import 'package:data_nime/pages/game_preview.dart';

class LibraryPage extends StatefulWidget {
  static const routeName = '/library';
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<Videojuego> favoritos = [];
  List<Videojuego> jugados = [];
  List<Videojuego> pendientes = [];

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    final allGames = await DatabaseHelper.instance.getAllGames();

    setState(() {
      favoritos = allGames.where((j) => j.favorito).toList();
      jugados = allGames.where((j) => j.jugado).toList();
      pendientes = allGames.where((j) => j.pendiente).toList();
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
              Tab(icon: Icon(Icons.check_box_outlined), text: "Jugados"),
              Tab(icon: Icon(Icons.schedule), text: "Pendientes"),
            ],
          ),
        ),
        drawer: const AppDrawer(),
        body: TabBarView(
          children: [
            _buildGameList(favoritos),
            _buildGameList(jugados),
            _buildGameList(pendientes),
          ],
        ),
      ),
    );
  }

  Widget _buildGameList(List<Videojuego> juegos) {
    if (juegos.isEmpty) {
      return const Center(child: Text('No hay juegos en esta categoría.'));
    }

    return ListView.builder(
      itemCount: juegos.length,
      itemBuilder: (context, index) {
        final juego = juegos[index];

        return InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        GamePreviewPage(juego: juego, onSaved: _loadGames),
              ),
            );
          },
          child: GameCard(
            imageUrl: juego.imagenUrl,
            gameName: juego.nombre,
            rating: juego.calificacion,
          ),
        );
      },
    );
  }
}
