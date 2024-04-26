import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/colors.dart';
import '../../../controllers/configuration_controller.dart';
import 'text_title.dart';

class ToleranceConfigurationTile extends StatefulWidget {
  const ToleranceConfigurationTile({super.key});

  @override
  State<ToleranceConfigurationTile> createState() =>
      _ToleranceConfigurationTileState();
}

class _ToleranceConfigurationTileState
    extends State<ToleranceConfigurationTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tertiaryColor,
      title: const TextTitle(text: 'Tolerancia'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Apertura de selección del dispositivo:",
            style: TextStyle(
              fontFamily: 'Mukta',
              fontWeight: FontWeight.w100,
              color: fontColor1,
              fontSize: 18,
            ),
          ),
          Builder(builder: (context) {
            final configurationController =
                Provider.of<ConfigurationController>(context);
            return Column(
              children: [
                Text(
                  "${configurationController.allowableRange.toStringAsFixed(0)}°",
                  style: const TextStyle(
                    fontFamily: 'Mukta',
                    fontWeight: FontWeight.w100,
                    color: fontColor1,
                    fontSize: 18,
                  ),
                ),
                Slider(
                  min: 2.0,
                  max: 100.0,
                  divisions: 98,
                  value: configurationController.allowableRange,
                  onChanged: (value) {
                    setState(() {
                      configurationController.setAllowableRange(value);
                    });
                  },
                  activeColor: primaryColor,
                  inactiveColor: primaryColorLight,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "cirujano",
                      style: TextStyle(
                        fontFamily: 'Mukta',
                        fontWeight: FontWeight.w100,
                        color: fontColor1,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "voraz",
                      style: TextStyle(
                        fontFamily: 'Mukta',
                        fontWeight: FontWeight.w100,
                        color: fontColor1,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}
