import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/colors.dart';
import '../../../controllers/configuration_controller.dart';
import '../../calibration/calibration_screen.dart';
import 'text_title.dart';

class BeaconsConfigurationTile extends StatefulWidget {
  const BeaconsConfigurationTile({super.key});

  @override
  State<BeaconsConfigurationTile> createState() =>
      _BeaconsConfigurationTileState();
}

class _BeaconsConfigurationTileState extends State<BeaconsConfigurationTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tertiaryColor,
      title: const TextTitle(text: 'Beacons'),
      subtitle: Builder(builder: (context) {
        final configurationController =
            Provider.of<ConfigurationController>(context);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Usar la configuración anterior',
                  style: TextStyle(
                    fontFamily: 'Mukta',
                    fontWeight: FontWeight.w100,
                    color: fontColor1,
                    fontSize: 18,
                  ),
                ),
                Switch(
                  value: configurationController.calibrationSwitch,
                  onChanged: (value) {
                    setState(() {
                      configurationController.setCalibrationSwitch(value);
                    });
                  },
                  activeColor: primaryColor,
                  inactiveTrackColor: dividerColor,
                ),
              ],
            ),
            (!configurationController.calibrationSwitch)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(80, 40),
                        backgroundColor: primaryColor,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ))),
                    child: const Text(
                      'Configurar',
                      style: TextStyle(
                        fontFamily: 'Mukta',
                        color: fontColor1,
                        fontWeight: FontWeight.w100,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CalibrationScreen()));
                    },
                  )
                : Container()
          ],
        );
      }),
    );
  }
}
