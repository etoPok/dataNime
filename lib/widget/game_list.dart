import 'package:flutter/material.dart';

class GameListView extends StatelessWidget {
  final List<Widget> games;

  const GameListView({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: games.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) => games[index],
    );
  }
}
