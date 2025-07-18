import 'package:flutter/material.dart';
import 'package:data_nime/pages/splash.dart';
import 'package:data_nime/theme/theme.dart';
import 'package:data_nime/theme/util.dart';
import 'package:data_nime/pages/anime_search.dart';
import 'package:data_nime/pages/library.dart';
import 'package:data_nime/pages/home.dart';
import 'package:data_nime/pages/about.dart';
import 'package:data_nime/pages/preferences.dart';
import 'package:data_nime/data/models/preferences_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:data_nime/utils/route_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (_) => PreferencesModel(),
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final preferences = context.watch<PreferencesModel>();

    TextTheme textTheme = createTextTheme(
      context,
      "M PLUS Rounded 1c",
      "Mochiy Pop One",
    );
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'dataNime',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: preferences.themeMode,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(title: 'Carga'),
        MyHomePage.routeName: (context) => const MyHomePage(title: 'Inicio'),
        AnimeSearchPage.routeName: (context) => AnimeSearchPage(),
        LibraryPage.routeName: (context) => const LibraryPage(),
        AboutPage.routeName: (context) => const AboutPage(),
        PreferencesPage.routeName: (context) => PreferencesPage(),
      },
      navigatorObservers: [routeObserver],
    );
  }
}
