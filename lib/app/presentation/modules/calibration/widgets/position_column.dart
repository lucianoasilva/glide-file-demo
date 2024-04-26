import 'package:flutter/material.dart';
import 'package:glide_file_demo/app/presentation/modules/calibration/widgets/position_cell.dart';

class PositionColumn extends StatelessWidget {
  const PositionColumn({
    super.key,
    required this.axis,
  });

  final int axis;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PositionCell(
          beaconNumber: 0,
          axis: axis,
        ),
        const SizedBox(height: 4),
        PositionCell(
          beaconNumber: 1,
          axis: axis,
        ),
        const SizedBox(height: 4),
        PositionCell(
          beaconNumber: 2,
          axis: axis,
        ),
      ],
    );
  }
}
