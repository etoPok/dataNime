import 'package:flutter/material.dart';
import 'package:videogame_rating/pages/profile.dart';
import 'package:videogame_rating/pages/games.dart';
import 'package:videogame_rating/pages/library.dart';
import 'package:flutter/services.dart';
import 'package:videogame_rating/widget/card_videogame.dart';

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
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  const Text(
                    'Ultimos éxitos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GameCard(
                    imageUrl:
                        'https://p325k7wa.twic.pics/high/clair-obscur/clair-obscur-expedition-33/00-page-setup/CO-EXP33-mobile-header.jpg?twic=v1/resize=760/step=10/quality=80',
                    gameName: 'Clair Obscur: Expedition 33',
                    rating: 9.7,
                  ),
                  GameCard(
                    imageUrl:
                        'https://external-preview.redd.it/AhGvOXy8VaXQWC4m6cEVhbtW_SxHI8PFZL4doLQ_wMY.jpg?width=640&crop=smart&auto=webp&s=b8963cd58719d9e9a055924ac005eda6018787eb',
                    gameName: 'The Elder Scrolls IV: Oblivion Remastered',
                    rating: 8.9,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ListView(
                children: <Widget>[
                  const Text(
                    'Más esperados',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GameCard(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS125Eh92mj-QyFcuHrFnFETGZAZjyG-4UUsg&s',
                    gameName: 'Grand Theft Auto VI',
                    rating: 0,
                  ),
                  GameCard(
                    imageUrl:
                        'https://i0.wp.com/levelup.buscafs.com/2025/04/Hollow-Knight-Silksong.jpg?fit=1280,960&quality=75&strip=all',
                    gameName: 'Hollow Knight: Silksong',
                    rating: 0,
                  ),
                  GameCard(
                    imageUrl:
                        'https://images.mweb.bethesda.net/_images/doom-the-dark-ages/doom-tda-premium-banner.webp?f=jpg&h=1030&w=1858&s=RUEHO3D3bUaIF88RAvCBhkU75xNd6nnDXHv5TaiDOAw',
                    gameName: 'Doom: The Dark Ages',
                    rating: 0,
                  ),
                  GameCard(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTsbJE5fS-QAOOXFkzc_sRfbjobXXXGwmvdANyV9CNDQxe0j5MDXEW52zwpah7p2zCBss&usqp=CAU',
                    gameName: 'Death Stranding 2',
                    rating: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
              leading: Icon(Icons.home_filled),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_sharp),
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
              leading: Icon(Icons.search),
              title: const Text('Explorar juegos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => GamePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: const Text('Mi blibioteca'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LibraryPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
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
