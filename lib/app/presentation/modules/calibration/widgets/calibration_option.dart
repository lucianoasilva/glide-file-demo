import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import 'text_field_label_text.dart';

class CalibrationOption extends StatelessWidget {
  const CalibrationOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Calibración",
              style: TextStyle(
                fontFamily: 'Mukta',
                fontWeight: FontWeight.bold,
                color: fontColor1,
                fontSize: 20,
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ))),
                onPressed: null,
                child: const TextFieldLabelText(
                  text: '(no disponible)',
                ),
              ),
            ),
          ]),
    );
  }
}
