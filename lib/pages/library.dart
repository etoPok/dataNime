import 'package:flutter/material.dart';
import 'package:videogame_rating/widget/card_videogame.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.favorite)),
                Tab(icon: Icon(Icons.save)),
                Tab(icon: Icon(Icons.check_box_outlined)),
              ],
            ),
            title: const Text('Biblioteca'),
          ),

          body: TabBarView(
            children: [
              ListView(
                children: <Widget>[
                  GameCard(
                    imageUrl:
                        'https://store-images.s-microsoft.com/image/apps.29727.67793643321489003.dd2aabd5-013d-491f-b85d-72606a4f8434.592bd1ae-48b0-4813-bfb4-00369a2e26e7?mode=scale&q=90&h=720&w=1280&background=%23FFFFFF',
                    gameName: 'Red Dead Redemption 2',
                    rating: 9.7,
                  ),
                  GameCard(
                    imageUrl:
                        'https://cdn1.epicgames.com/offer/24b9b5e323bc40eea252a10cdd3b2f10/EGS_LeagueofLegends_RiotGames_S1_2560x1440-80471666c140f790f28dff68d72c384b',
                    gameName: 'League of legends',
                    rating: 8.5,
                  ),
                  GameCard(
                    imageUrl:
                        'https://shared.cloudflare.steamstatic.com/store_item_assets/steam/apps/105600/capsule_616x353.jpg?t=1731252354',
                    gameName: 'Terraria',
                    rating: 10,
                  ),
                  GameCard(
                    imageUrl:
                        'https://i0.wp.com/www.vozactual.com/wp-content/uploads/2020/05/gta-portada.jpg?fit=1024%2C576&ssl=1',
                    gameName: 'Grand Theft Auto V',
                    rating: 9.7,
                  ),
                  GameCard(
                    imageUrl:
                        'https://assets.nintendo.com/image/upload/ar_16:9,c_lpad,w_1240/b_white/f_auto/q_auto/ncom/software/switch/70010000003208/4643fb058642335c523910f3a7910575f56372f612f7c0c9a497aaae978d3e51',
                    gameName: 'Hollow Knight',
                    rating: 9.1,
                  ),
                ],
              ),
              ListView(
                children: <Widget>[
                  GameCard(
                    imageUrl:
                        'https://store-images.s-microsoft.com/image/apps.29727.67793643321489003.dd2aabd5-013d-491f-b85d-72606a4f8434.592bd1ae-48b0-4813-bfb4-00369a2e26e7?mode=scale&q=90&h=720&w=1280&background=%23FFFFFF',
                    gameName: 'Red Dead Redemption 2',
                    rating: 9.7,
                  ),
                  GameCard(
                    imageUrl:
                        'https://i0.wp.com/www.vozactual.com/wp-content/uploads/2020/05/gta-portada.jpg?fit=1024%2C576&ssl=1',
                    gameName: 'Grand Theft Auto V',
                    rating: 9.7,
                  ),
                ],
              ),
              ListView(
                children: <Widget>[
                  GameCard(
                    imageUrl:
                        'https://cdn1.epicgames.com/offer/24b9b5e323bc40eea252a10cdd3b2f10/EGS_LeagueofLegends_RiotGames_S1_2560x1440-80471666c140f790f28dff68d72c384b',
                    gameName: 'League of legends',
                    rating: 8.5,
                  ),
                  GameCard(
                    imageUrl:
                        'https://shared.cloudflare.steamstatic.com/store_item_assets/steam/apps/105600/capsule_616x353.jpg?t=1731252354',
                    gameName: 'Terraria',
                    rating: 10,
                  ),
                  GameCard(
                    imageUrl:
                        'https://assets.nintendo.com/image/upload/ar_16:9,c_lpad,w_1240/b_white/f_auto/q_auto/ncom/software/switch/70010000003208/4643fb058642335c523910f3a7910575f56372f612f7c0c9a497aaae978d3e51',
                    gameName: 'Hollow Knight',
                    rating: 9.1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
