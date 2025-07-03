import 'package:flutter/material.dart';
import 'package:data_nime/widget/app_drawer.dart';
import 'package:data_nime/data/services/database_helper.dart';
import 'package:data_nime/domain/entities/anime.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  static const routeName = '/home';
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Anime> allAnimes = [];

  @override
  void initState() {
    super.initState();
    _loadAnimes();
  }

  Future<void> _loadAnimes() async {
    final animes = await DatabaseHelper.instance.getAllAnimes();
    if (!mounted) return;

    setState(() {
      allAnimes.addAll(animes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
          bottom: const TabBar(
            tabs: [Tab(text: 'Mejores Animes'), Tab(text: 'Ruleta')]
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: allAnimes.length,
              itemBuilder: (context, index) {
                final anime = allAnimes[index];
                return InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(anime.title),
                    subtitle: Text("${anime.id}")
                  )
                );
              },
            ),
            SizedBox.shrink()
          ],
        ),
        drawer: const AppDrawer(),
      ),
    );
  }
}
