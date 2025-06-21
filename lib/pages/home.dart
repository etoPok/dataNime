import 'package:flutter/material.dart';
import 'package:videogame_rating/widget/card_videogame.dart';
import 'package:videogame_rating/widget/app_drawer.dart';
import 'package:videogame_rating/data/services/database_helper.dart';
import 'package:videogame_rating/domain/entities/videogame.dart';
import 'package:videogame_rating/pages/game_preview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  static const routeName = '/home';
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Videojuego> topGames = [];
  List<Videojuego> randomGames = [];
  List<Videojuego> allGames = [];

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    final games = await DatabaseHelper.instance.getAllGames();
    if (!mounted) return;

    // Ordenar por calificación descendente
    final sorted = List<Videojuego>.from(games)
      ..sort((a, b) => b.calificacion.compareTo(a.calificacion));

    setState(() {
      allGames = games;
      topGames = sorted.take(50).toList();
      _randomizeGames();
    });
  }

  void _randomizeGames() {
    if (allGames.length >= 3) {
      final shuffled = List<Videojuego>.from(allGames)..shuffle();
      setState(() {
        randomGames = shuffled.take(3).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
          bottom: const TabBar(
            tabs: [Tab(text: 'Mejores Juegos'), Tab(text: 'Ruleta')],
          ),
        ),
        body: TabBarView(
          children: [
            // Mejores juegos
            ListView.builder(
              itemCount: topGames.length,
              itemBuilder: (context, index) {
                final game = topGames[index];
                return InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => GamePreviewPage(
                              juego: game,
                              onSaved: _loadGames,
                            ),
                      ),
                    );
                  },
                  child: GameCard(
                    imageUrl: game.imagenUrl,
                    gameName: game.nombre,
                    rating: game.calificacion,
                  ),
                );
              },
            ),
            // Recomendación aleatoria
            Center(
              child:
                  randomGames.isEmpty
                      ? const CircularProgressIndicator()
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...randomGames.map(
                            (game) => Padding(
                              padding: const EdgeInsets.symmetric(),
                              child: SizedBox(
                                height: 180,
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => GamePreviewPage(
                                              juego: game,
                                              onSaved: _loadGames,
                                            ),
                                      ),
                                    );
                                  },
                                  child: GameCard(
                                    imageUrl: game.imagenUrl,
                                    gameName: game.nombre,
                                    rating: game.calificacion,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _randomizeGames,
                            icon: const Icon(Icons.refresh),
                            label: const Text("Tirar otra vez"),
                          ),
                        ],
                      ),
            ),
          ],
        ),
        drawer: const AppDrawer(),
      ),
    );
  }
}
