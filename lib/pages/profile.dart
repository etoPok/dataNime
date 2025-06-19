import 'package:flutter/material.dart';
import 'package:videogame_rating/widget/app_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});
  static const routeName = '/profile';
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 32),
                      ClipOval(
                        child: Image.asset(
                          'assets/perfil.jpg',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Balatro Balatrez',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'balatrez@gmail.com',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 96),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                        width: 180,
                        child: Card(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Juegos gustado\n23',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        width: 180,
                        child: Card(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Juegos por jugar\n10',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        width: 180,
                        child: Card(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Juegos jugados\n48',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit_note),
              title: const Text('Editar perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Cerrar sesion'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
