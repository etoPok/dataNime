import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeMorePressed;
  final Widget button;

  const SectionHeader({
    super.key,
    required this.title,
    this.button = const Text("Ver más >", style: TextStyle(fontSize: 16)),
    this.onSeeMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onSeeMorePressed != null)
            TextButton(
              onPressed: onSeeMorePressed,
              child: button
            ),
        ],
      ),
    );
  }
}