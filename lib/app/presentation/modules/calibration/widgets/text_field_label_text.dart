import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class TextFieldLabelText extends StatelessWidget {
  const TextFieldLabelText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Mukta',
        color: fontColor1,
        fontSize: 18,
      ),
    );
  }
}
