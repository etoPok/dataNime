import 'package:flutter/material.dart';

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

          body: const TabBarView(
            children: [
              Icon(Icons.favorite),
              Icon(Icons.save),
              Icon(Icons.check_box_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
