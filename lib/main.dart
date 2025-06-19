import 'package:flutter/material.dart';
import 'package:videogame_rating/pages/splash.dart';
import 'package:videogame_rating/theme/theme.dart';
import 'package:videogame_rating/theme/util.dart';
import 'package:videogame_rating/pages/profile.dart';
import 'package:videogame_rating/pages/games.dart';
import 'package:videogame_rating/pages/library.dart';
import 'package:videogame_rating/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Rubik", "Bungee");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Game Gauge',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(title: 'Carga'),
        MyHomePage.routeName: (context) => const MyHomePage(title: 'Inicio'),
        ProfilePage.routeName: (context) => const ProfilePage(title: 'Perfil'),
        GamePage.routeName: (context) => GamePage(),
        LibraryPage.routeName: (context) => const LibraryPage(),
      },
    );
  }
}
