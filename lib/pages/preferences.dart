import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:data_nime/data/models/preferences_model.dart';
import 'package:data_nime/widget/app_drawer.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});
  static const routeName = '/preferences';

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  @override
  void initState() {
    super.initState();
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
          ],
        ),
      ),
    );
  }
}
