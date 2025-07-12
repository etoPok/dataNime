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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (onSeeMorePressed != null)
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: TextButton(
              onPressed: onSeeMorePressed,
              child: button,
            ),
          ),
      ],
    );
  }
}