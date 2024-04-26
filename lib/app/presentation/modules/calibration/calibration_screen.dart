import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/stored_data_controller.dart';
import '../alerts/alerts.dart';
import '../../config/colors.dart';
import '../../../data/services/file_storage_service.dart';
import '../../../domain/entity/calibration.dart';

import 'widgets/calibration_widgets.dart';

class CalibrationScreen extends StatelessWidget {
  const CalibrationScreen({
    super.key,
  });

  Future<void> _saveCalibration(
      Calibration calibration, BuildContext context) async {
    try {
      await FileStorageService.saveCalibration(calibration);
    } catch (e) {
      print("CALIBRATION SCREEN :::: exception: $e");
      showErrorToastException(context, "Calibration (saveCalibration)", e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: secondaryColor,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 50,
            bottom: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Beacons",
                style: TextStyle(
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.bold,
                  color: fontColor1,
                  fontSize: 24,
                ),
              ),
              const Divider(color: dividerColor),
              const ListTile(
                tileColor: tertiaryColor,
                title: Text(
                  "Posición",
                  style: TextStyle(
                    fontFamily: 'Mukta',
                    fontWeight: FontWeight.bold,
                    color: fontColor1,
                    fontSize: 20,
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PositionBeaconIndicator(),
                    PositionColumn(axis: 0),
                    PositionColumn(axis: 1),
                  ],
                ),
              ),
              const Divider(color: dividerColor),
              const CalibrationOption(),
              const Divider(color: dividerColor),
              Center(
                child: Builder(builder: (context) {
                  final controller = Provider.of<StoredDataController>(context);
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(80, 40),
                        backgroundColor: primaryColor,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ))),
                    onPressed: () {
                      controller.updatePositionFromTemp();
                      final Calibration calibration = Calibration(
                        controller.blueberryPosition[0],
                        controller.blueberryPosition[1],
                        controller.icePosition[0],
                        controller.icePosition[1],
                        controller.mintPosition[0],
                        controller.mintPosition[1],
                      );
                      _saveCalibration(calibration, context);
                      Navigator.pop(context);
                    },
                    child: const TextFieldLabelText(text: 'Guardar ajustes'),
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
