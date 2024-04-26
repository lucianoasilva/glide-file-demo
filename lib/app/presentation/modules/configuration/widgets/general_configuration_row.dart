import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class GeneralConfigurationRow extends StatelessWidget {
  const GeneralConfigurationRow({
    super.key,
    required this.circleColor,
    required this.title,
    required this.icon,
    required this.configurationSwitch,
  });

  final Color circleColor;
  final String title;
  final IconData icon;
  final Switch configurationSwitch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            const SizedBox(width: 30),
            CircleAvatar(
              backgroundColor: circleColor,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Mukta',
                fontWeight: FontWeight.w100,
                color: fontColor1,
                fontSize: 18,
              ),
            ),
          ],
        ),
        configurationSwitch,
      ],
    );
  }
}
