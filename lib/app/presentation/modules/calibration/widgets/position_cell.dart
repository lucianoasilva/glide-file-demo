import 'package:flutter/material.dart';

import 'position_text_field.dart';
import 'text_field_label_text.dart';

class PositionCell extends StatelessWidget {
  const PositionCell({
    super.key,
    required this.beaconNumber,
    required this.axis,
  });

  final int beaconNumber;
  final int axis;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TextFieldLabelText(text: (axis == 0) ? 'x: ' : 'y: '),
        PositionTextField(
          beaconNumber: beaconNumber,
          axis: axis,
        ),
        const TextFieldLabelText(text: 'm'),
      ],
    );
  }
}
