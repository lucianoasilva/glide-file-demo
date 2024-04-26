import 'package:flutter/material.dart';
import 'text_field_label_text.dart';

class PositionBeaconIndicator extends StatelessWidget {
  const PositionBeaconIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFieldLabelText(text: 'Blueberry'),
        SizedBox(height: 4),
        TextFieldLabelText(text: 'Ice'),
        SizedBox(height: 4),
        TextFieldLabelText(text: 'Mint'),
      ],
    );
  }
}
