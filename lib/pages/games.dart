import 'package:flutter/material.dart';
import 'package:videogame_rating/domain/entities/videogame.dart';
import 'package:videogame_rating/data/services/database_helper.dart';
import 'package:videogame_rating/widget/app_drawer.dart';
import 'package:videogame_rating/widget/game_preview.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  static const routeName = '/games';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Videojuego> _allGames = [];
  List<Videojuego> _filteredGames = [];
  bool _sortByRatingDescending = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGamesFromDB();
  }

  Future<void> _loadGamesFromDB() async {
    final games = await DatabaseHelper.instance.getAllGames();
    setState(() {
      _allGames = games;
      _filteredGames = List.from(_allGames);
    });
  }

  void _filterGames(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredGames = List.from(_allGames);
      } else {
        _filteredGames =
            _allGames
                .where(
                  (game) =>
                      game.nombre.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
      _sortGames();
    });
  }

  void _sortGames() {
    _filteredGames.sort((a, b) {
      return _sortByRatingDescending
          ? b.calificacion.compareTo(a.calificacion)
          : a.calificacion.compareTo(b.calificacion);
    });
  }

  Future<void> _toggleFavorite(Videojuego juego) async {
    final updatedGame = Videojuego(
      id: juego.id,
      nombre: juego.nombre,
      genero: juego.genero,
      calificacion: juego.calificacion,
      plataformas: juego.plataformas,
      anio: juego.anio,
      imagenUrl: juego.imagenUrl,
      favorito: !juego.favorito,
      jugado: juego.jugado,
      pendiente: juego.pendiente,
    );

    await DatabaseHelper.instance.updateGame(updatedGame);
    await _loadGamesFromDB();
  }

  @override
  Widget build(BuildContext context) {
    _sortGames();

    return Scaffold(
      appBar: AppBar(title: const Text('Explorar Juegos')),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterGames,
              decoration: const InputDecoration(
                labelText: 'Buscar por nombre',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                filled: true,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              _sortByRatingDescending
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
            ),
            onPressed: () {
              setState(() {
                _sortByRatingDescending = !_sortByRatingDescending;
                _sortGames();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredGames.length,
              itemBuilder: (context, index) {
                final game = _filteredGames[index];
                return ListTile(
                  leading: Image.network(
                    game.imagenUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) => const Icon(Icons.broken_image),
                  ),
                  title: Text('${game.nombre} (${game.anio})'),
                  subtitle: Text('${game.genero} - ${game.calificacion}'),
                  trailing: IconButton(
                    icon: Icon(
                      game.favorito ? Icons.favorite : Icons.favorite_border,
                      color: game.favorito ? Colors.red : null,
                    ),
                    onPressed: () => _toggleFavorite(game),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: GamePreviewWidget(
                                juego: game,
                                onSaved:
                                    _loadGamesFromDB, // refresca lista al guardar
                              ),
                            ),
                          ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
