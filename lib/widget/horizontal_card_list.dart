import 'package:flutter/material.dart';

class HorizontalCardList extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double cardWidth;
  final double cardHeight;

  const HorizontalCardList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.cardWidth = 120.0,
    this.cardHeight = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: itemBuilder(context, index),
            ),
          );
        },
      ),
    );
  }
}