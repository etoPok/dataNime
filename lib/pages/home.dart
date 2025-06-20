import 'package:flutter/material.dart';
import 'package:videogame_rating/widget/card_videogame.dart';
import 'package:videogame_rating/widget/app_drawer.dart';
import 'package:videogame_rating/widget/game_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  static const routeName = '/home';
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
          bottom: const TabBar(
            tabs: [Tab(text: 'Últimos éxitos'), Tab(text: 'Más esperados')],
          ),
        ),
        body: const TabBarView(
          children: [
            GameListView(
              games: [
                GameCard(
                  imageUrl:
                      'https://p325k7wa.twic.pics/high/clair-obscur/clair-obscur-expedition-33/00-page-setup/CO-EXP33-mobile-header.jpg?twic=v1/resize=760/step=10/quality=80',
                  gameName: 'Clair Obscur: Expedition 33',
                  rating: 9.7,
                ),
                GameCard(
                  imageUrl:
                      'https://external-preview.redd.it/AhGvOXy8VaXQWC4m6cEVhbtW_SxHI8PFZL4doLQ_wMY.jpg?width=640&crop=smart&auto=webp&s=b8963cd58719d9e9a055924ac005eda6018787eb',
                  gameName: 'Oblivion Remastered',
                  rating: 8.9,
                ),
              ],
            ),

            GameListView(
              games: [
                GameCard(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS125Eh92mj-QyFcuHrFnFETGZAZjyG-4UUsg&s',
                  gameName: 'GTA VI',
                  rating: 0,
                ),
                GameCard(
                  imageUrl:
                      'https://i0.wp.com/levelup.buscafs.com/2025/04/Hollow-Knight-Silksong.jpg?fit=1280,960&quality=75&strip=all',
                  gameName: 'Silksong',
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
          ],
        ),
        drawer: const AppDrawer(),
      ),
    );
  }
}
