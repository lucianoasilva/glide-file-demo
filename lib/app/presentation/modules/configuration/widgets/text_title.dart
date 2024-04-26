import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Mukta',
        fontWeight: FontWeight.bold,
        color: fontColor1,
        fontSize: 20,
      ),
    );
  }
}
