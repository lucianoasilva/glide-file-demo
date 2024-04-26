import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.iconButton,
    required this.color,
  });

  final IconButton iconButton;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: Container(
        height: 100,
        color: color,
        padding: const EdgeInsets.all(5),
        child: iconButton,
      ),
    );
  }
}
