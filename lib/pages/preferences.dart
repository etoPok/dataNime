import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videogame_rating/data/models/preferences_model.dart';
import 'package:videogame_rating/widget/app_drawer.dart';

class PreferencesPage extends StatelessWidget {
  static const routeName = '/preferences';
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

  @override
  Widget build(BuildContext context) {
    final preferences = context.watch<PreferencesModel>();
    ThemeMode current = preferences.themeMode;

    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tema de la aplicación', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            DropdownButton<ThemeMode>(
              value: current,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('Sistema'),
                ),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Claro')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Oscuro')),
              ],
              onChanged: (ThemeMode? mode) {
                if (mode != null) {
                  preferences.setThemeMode(mode);
                }
              },
            ),

            const SizedBox(height: 24),

            SwitchListTile(
              title: const Text('Mostrar resumen de juego'),
              value: preferences.showSummary,
              onChanged: (bool value) {
                preferences.setShowSummary(value);
              },
            ),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Filtrar por plataforma',
              ),
              value: preferences.platformFilter,
              items: [
                const DropdownMenuItem(value: null, child: Text('Todas')),
                ...platforms.map(
                  (p) => DropdownMenuItem(value: p, child: Text(p)),
                ),
              ],
              onChanged: (value) {
                preferences.platformFilter = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
