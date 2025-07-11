import 'package:flutter/material.dart';
import 'package:data_nime/widget/app_drawer.dart';
import 'package:data_nime/domain/entities/videogame.dart';

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
        return InkWell(onTap: () async {});
      },
    );
  }
}
