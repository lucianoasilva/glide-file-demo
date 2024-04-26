import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import 'text_title.dart';

class OrientationConfigurationTile extends StatelessWidget {
  const OrientationConfigurationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tertiaryColor,
      title: const TextTitle(text: 'Orientación'),
      subtitle: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ángulo Beta",
            style: TextStyle(
              fontFamily: 'Mukta',
              color: fontColor1,
              fontSize: 16,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "x: 0.0, ",
                style: TextStyle(
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.w100,
                  color: fontColor1,
                  fontSize: 15,
                ),
              ),
              Text(
                "y: 0.0, ",
                style: TextStyle(
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.w100,
                  color: fontColor1,
                  fontSize: 15,
                ),
              ),
              Text(
                "z: 0.0",
                style: TextStyle(
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.w100,
                  color: fontColor1,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(80, 40),
            backgroundColor: primaryColor,
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(20),
            ))),
        onPressed: null,
        child: const Text(
          '(no disponible)',
          style: TextStyle(
            fontFamily: 'Mukta',
            color: fontColor1,
            fontWeight: FontWeight.w100,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
