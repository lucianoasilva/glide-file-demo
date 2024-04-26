import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class LogoNameWidget extends StatelessWidget {
  const LogoNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 170,
          child: Image.asset(
            'resources/icons/glide-file_logo.png',
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Glide-File',
              style: TextStyle(
                fontFamily: 'LobsterTwo',
                color: fontColor1,
                fontStyle: FontStyle.italic,
                fontSize: 50,
              ),
            ),
            const SizedBox(width: 3),
            Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: primaryColor,
              ),
              child: const Text(
                'Front Demo',
                style: TextStyle(
                  fontFamily: 'Mukta',
                  color: fontColor1,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 32),
          ],
        ),
      ],
    );
  }
}
