import 'package:flutter/material.dart';
import 'package:videogame_rating/entitys/videogame.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePage();
}

class _GamePage extends State<GamePage> {
  List<Videojuego> allVideojuegos = [
    Videojuego(
      nombre: 'The Legend of Zelda: Tears of the Kingdom',
      genero: 'Aventura',
      calificacion: 9.8,
      plataformas: ['Nintendo Switch'],
      anio: 2023,
    ),
    Videojuego(
      nombre: 'Red Dead Redemption 2',
      genero: 'Acción-Aventura',
      calificacion: 9.7,
      plataformas: ['PS4', 'Xbox One', 'PC'],
      anio: 2018,
    ),
    Videojuego(
      nombre: 'Minecraft',
      genero: 'Sandbox',
      calificacion: 9.5,
      plataformas: ['Multiplataforma'],
      anio: 2011,
    ),
    Videojuego(
      nombre: 'League of legends',
      genero: 'MOBA',
      calificacion: 8.5,
      plataformas: ['PC'],
      anio: 2009,
    ),
    Videojuego(
      nombre: 'Stardew Valley',
      genero: 'Simulación',
      calificacion: 9.0,
      plataformas: ['Multiplataforma'],
      anio: 2016,
    ),
    Videojuego(
      nombre: 'Balatro',
      genero: 'Roguelike',
      calificacion: 9.6,
      plataformas: ['Multiplataforma'],
      anio: 2024,
    ),
  ];
  List<Videojuego> filteredVideojuegos = [];
  TextEditingController searchController = TextEditingController();
  bool _sortByRatingDescending = true;
  final List<bool> _isFavoriteList = [];

  @override
  void initState() {
    super.initState();
    filteredVideojuegos.addAll(allVideojuegos);
    _isFavoriteList.addAll(
      List.generate(allVideojuegos.length, (index) => false),
    );
  }

  void _filterVideojuegos(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredVideojuegos.clear();
        filteredVideojuegos.addAll(allVideojuegos);
      } else {
        filteredVideojuegos =
            allVideojuegos
                .where(
                  (videojuego) => videojuego.nombre.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
                )
                .toList();
      }
      _sortFilteredVideojuegos();
    });
  }

  void _sortFilteredVideojuegos() {
    setState(() {
      filteredVideojuegos.sort((a, b) {
        if (_sortByRatingDescending) {
          return b.calificacion.compareTo(a.calificacion); // Orden descendente
        } else {
          return a.calificacion.compareTo(b.calificacion); // Orden ascendente
        }
      });
    });
  }

  void _toggleIcon(int i) {
    setState(() {
      _isFavoriteList[i] = !_isFavoriteList[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    _sortFilteredVideojuegos();
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text('Buscar Videojuegos'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterVideojuegos,
              decoration: InputDecoration(
                labelText: 'Buscar por nombre',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
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
                _sortFilteredVideojuegos();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredVideojuegos.length,
              itemBuilder: (context, index) {
                final videojuego = filteredVideojuegos[index];
                final isFavorite = _isFavoriteList[index];
                return ListTile(
                  title: Text(
                    '${videojuego.nombre} - ${videojuego.calificacion}',
                  ),
                  subtitle: Text(
                    '${videojuego.genero} (${videojuego.anio}) - ${videojuego.plataformas.join(", ")}',
                  ),
                  trailing: IconButton(
                    onPressed: () => _toggleIcon(index),
                    icon:
                        isFavorite
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
