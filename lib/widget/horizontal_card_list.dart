import 'package:flutter/material.dart';

class HorizontalCardList extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double cardWidth;
  final double cardHeight;
  final double horizontalPadding;
  final double spacing;

  const HorizontalCardList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.cardWidth = 120.0,
    this.cardHeight = 200.0,
    this.horizontalPadding = 16.0,
    this.spacing = 8.0
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: spacing),
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