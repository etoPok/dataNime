import 'package:flutter/material.dart';
import 'package:videogame_rating/domain/entities/videogame.dart';
import 'package:videogame_rating/data/services/database_helper.dart';
import 'package:videogame_rating/widget/app_drawer.dart';
import 'package:videogame_rating/pages/game_preview.dart';
import 'package:videogame_rating/data/models/preferences_model.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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

  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();

    _speech = stt.SpeechToText();
    _loadGamesFromDB();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            if (!mounted) return;
            setState(() {
              _searchController.text = result.recognizedWords;
              _filterGames(result.recognizedWords);
            });
          },
          listenFor: const Duration(seconds: 5),
          pauseFor: const Duration(seconds: 3),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _loadGamesFromDB() async {
    final games = await DatabaseHelper.instance.getAllGames();
    if (!mounted) return;
    final prefs = context.read<PreferencesModel>();

    setState(() {
      _allGames = games;
      _filteredGames =
          games.where((game) {
            final matchesPlatform =
                prefs.platformFilter == null ||
                game.plataformas.contains(prefs.platformFilter);

            final matchesGenre =
                prefs.selectedGenre == null ||
                game.genero.any(
                  (g) => g.toLowerCase().contains(
                    prefs.selectedGenre!.toLowerCase(),
                  ),
                );

            return matchesPlatform && matchesGenre;
          }).toList();
      _sortGames();
    });
  }

  void _filterGames(String query) {
    setState(() {
      _filteredGames =
          query.isEmpty
              ? List.from(_allGames)
              : _allGames
                  .where(
                    (game) =>
                        game.nombre.toLowerCase().contains(query.toLowerCase()),
                  )
                  .toList();
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

  Future<void> _toggleFlag(Videojuego juego, String flag) async {
    final updatedGame = juego.copyWith(
      favorito: flag == 'favorito' ? !juego.favorito : juego.favorito,
      jugado: flag == 'jugado' ? !juego.jugado : juego.jugado,
      pendiente: flag == 'pendiente' ? !juego.pendiente : juego.pendiente,
    );
    await DatabaseHelper.instance.updateGame(updatedGame);
    await _loadGamesFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explorar Juegos')),
      drawer: const AppDrawer(),
      body:
          _allGames.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _filterGames,
                            decoration: const InputDecoration(
                              labelText: 'Buscar por nombre',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                          onPressed: _listen,
                        ),
                      ],
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
                          subtitle: Text(
                            '${game.genero} - ${game.calificacion.toStringAsFixed(1)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Favorito',
                                icon: Icon(
                                  game.favorito
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: game.favorito ? Colors.red : null,
                                ),
                                onPressed: () => _toggleFlag(game, 'favorito'),
                              ),
                            ],
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => GamePreviewPage(
                                      juego: game,
                                      onSaved: _loadGamesFromDB,
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
