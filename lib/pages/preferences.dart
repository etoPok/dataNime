import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:data_nime/data/models/preferences_model.dart';
import 'package:data_nime/widget/app_drawer.dart';
import 'package:data_nime/data/services/database_helper.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});
  static const routeName = '/preferences';

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final List<String> platforms = [
    'PC',
    'PlayStation 4',
    'PlayStation 5',
    'Xbox One',
    'Xbox Series S/X',
    'Nintendo Switch',
    'Android',
    'iOS',
  ];

  List<String> genres = [];
  bool _loadingGenres = true;

  @override
  void initState() {
    super.initState();
    _loadGenres();
  }

  Future<void> _loadGenres() async {
    final juegos = await DatabaseHelper.instance.getAllGames();

    final allGenres =
        juegos
            .expand((j) => j.genero)
            .where((g) => g.trim().isNotEmpty)
            .toSet()
            .toList();

    allGenres.sort();

    if (!mounted) return;
    setState(() {
      genres = allGenres;
      _loadingGenres = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final preferences = context.watch<PreferencesModel>();
    ThemeMode current = preferences.themeMode;

    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:
            _loadingGenres
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tema de la aplicación',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<ThemeMode>(
                      value: current,
                      items: const [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text('Sistema'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text('Claro'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text('Oscuro'),
                        ),
                      ],
                      onChanged: (ThemeMode? mode) {
                        if (mode != null) {
                          preferences.setThemeMode(mode);
                        }
                      },
                    ),

                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Filtrar por plataforma',
                      ),
                      value: preferences.platformFilter,
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('Todas'),
                        ),
                        ...platforms.map(
                          (p) => DropdownMenuItem(value: p, child: Text(p)),
                        ),
                      ],
                      onChanged: (value) {
                        preferences.platformFilter = value;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: preferences.selectedGenre,
                      decoration: const InputDecoration(
                        labelText: "Filtrar por género",
                      ),
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text("Todos los géneros"),
                        ),
                        ...genres.map(
                          (g) => DropdownMenuItem(value: g, child: Text(g)),
                        ),
                      ],
                      onChanged: preferences.setSelectedGenre,
                    ),
                    const SizedBox(height: 24),

                    SwitchListTile(
                      title: const Text('Mostrar resumen de juego'),
                      value: preferences.showSummary,
                      onChanged: (bool value) {
                        preferences.setShowSummary(value);
                      },
                    ),
                  ],
                ),
      ),
    );
  }
}
