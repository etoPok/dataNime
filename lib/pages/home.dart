import 'package:flutter/material.dart';
import 'package:videogame_rating/pages/profile.dart';
import 'package:videogame_rating/pages/games.dart';
import 'package:videogame_rating/pages/library.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      backgroundColor: Colors.deepPurple[50],
      body: Center(),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 96,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Text('Menú'),
              ),
            ),

            ListTile(
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(title: 'Perfil'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Explorar juegos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => GamePage()));
              },
            ),
            ListTile(
              title: const Text('Mi blibioteca'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LibraryPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Salir'),
              onTap: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        ),
      ),
    );
  }
}
