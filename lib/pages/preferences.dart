import 'package:flutter/material.dart';
import 'package:videogame_rating/widget/app_drawer.dart';

class PreferencesPage extends StatefulWidget {
  static const routeName = '/preferences';
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('Preferencias')),
        drawer: const AppDrawer(),
      ),
    );
  }
}
