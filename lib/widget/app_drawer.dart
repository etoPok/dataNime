import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:data_nime/pages/home.dart';
import 'package:data_nime/pages/preferences.dart';
import 'package:data_nime/pages/anime_search.dart';
import 'package:data_nime/pages/library.dart';
import 'package:data_nime/pages/about.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 96,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'dataNime',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_filled),
            title: const Text('Inicio'),
            onTap: () {
              if (currentRoute != MyHomePage.routeName) {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(MyHomePage.routeName);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Explorar animes'),
            onTap: () {
              if (currentRoute != AnimeSearchPage.routeName) {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(AnimeSearchPage.routeName);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Mi biblioteca'),
            onTap: () {
              if (currentRoute != LibraryPage.routeName) {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(LibraryPage.routeName);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Preferencias'),
            onTap: () {
              if (currentRoute != PreferencesPage.routeName) {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(PreferencesPage.routeName);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Acerca de'),
            onTap: () {
              if (currentRoute != AboutPage.routeName) {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(AboutPage.routeName);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Salir'),
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ],
      ),
    );
  }
}
