import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/calibration_controller.dart';
import '../data/stored_data.dart';
import '../data/calibration.dart';
import '../styles/colors.dart';

class CalibrationWidget extends StatefulWidget {
  const CalibrationWidget({super.key, required this.storedData});

  final StoredData storedData;

  @override
  State<CalibrationWidget> createState() => _CalibrationWidgetState();
}

class _CalibrationWidgetState extends State<CalibrationWidget> {
  final TextEditingController controllerBPosX = TextEditingController();
  final TextEditingController controllerBPosY = TextEditingController();
  final TextEditingController controllerIPosX = TextEditingController();
  final TextEditingController controllerIPosY = TextEditingController();
  final TextEditingController controllerMPosX = TextEditingController();
  final TextEditingController controllerMPosY = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateTextFieldValues();
  }

  _updateTextFieldValues() {
    setState(() {
      controllerBPosX.text = widget.storedData.blueberryPosition[0].toString();
      controllerBPosY.text = widget.storedData.blueberryPosition[1].toString();
      controllerIPosX.text = widget.storedData.icePosition[0].toString();
      controllerIPosY.text = widget.storedData.icePosition[1].toString();
      controllerMPosX.text = widget.storedData.mintPosition[0].toString();
      controllerMPosY.text = widget.storedData.mintPosition[1].toString();
    });
  }

  Future<void> _saveCalibration() async {
    final Calibration calibration = Calibration(
        widget.storedData.blueberryPosition[0],
        widget.storedData.blueberryPosition[1],
        widget.storedData.icePosition[0],
        widget.storedData.icePosition[1],
        widget.storedData.mintPosition[0],
        widget.storedData.mintPosition[1]);
    try {
      await CalibrationController.saveCalibration(calibration);
    } catch (e) {
      print("CALIBRATION WIDGET :::: exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: secondaryColor,
        child: ListView(
          children: <Widget>[
            const Row(children: [
              SizedBox(width: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      "Beacons",
                      style: TextStyle(
                        fontFamily: 'Mukta',
                        fontWeight: FontWeight.bold,
                        color: fontColor1,
                        fontSize: 24,
                      ),
                    ),
                  ])
            ]),
            const Divider(color: dividerColor),
            ListTile(
              tileColor: tertiaryColor,
              title: const Text(
                "Posición",
                style: TextStyle(
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.bold,
                  color: fontColor1,
                  fontSize: 20,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Blueberry",
                            style: TextStyle(
                              fontFamily: 'Mukta',
                              color: fontColor1,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Ice",
                            style: TextStyle(
                              fontFamily: 'Mukta',
                              color: fontColor1,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mint",
                            style: TextStyle(
                              fontFamily: 'Mukta',
                              color: fontColor1,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Text(
                                "x: ",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: dividerColor),
                                ),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                                margin:
                                const EdgeInsets.symmetric(horizontal: 3),
                                child: TextField(
                                  controller: controllerBPosX,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d{0,1}([.,]\d{0,2})?'),
                                    ),
                                  ],
                                  onSubmitted: (String value) {
                                    setState(() {
                                      widget.storedData.blueberryPosition[0] = (
                                          double.tryParse(
                                              value.replaceAll(',', '.'))!);
                                    });
                                  },
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: const TextStyle(
                                    fontFamily: 'Mukta',
                                    fontSize: 18,
                                  ),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: "0,00",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Mukta',
                                        fontSize: 18,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                              const Text(
                                "m",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: <Widget>[
                              const Text(
                                "x: ",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: dividerColor),
                                ),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                                margin:
                                const EdgeInsets.symmetric(horizontal: 3),
                                child: TextField(
                                  controller: controllerIPosX,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d{0,1}([.,]\d{0,2})?'),
                                    ),
                                  ],
                                  onSubmitted: (String value) {
                                    setState(() {
                                      widget.storedData.icePosition[0] = (
                                          double.tryParse(
                                              value.replaceAll(',', '.'))!);
                                    });
                                  },
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: const TextStyle(
                                    fontFamily: 'Mukta',
                                    fontSize: 18,
                                  ),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: "0,00",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Mukta',
                                        fontSize: 18,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                              const Text(
                                "m",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: <Widget>[
                              const Text(
                                "x: ",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: dividerColor),
                                ),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                                margin:
                                const EdgeInsets.symmetric(horizontal: 3),
                                child: TextField(
                                  controller: controllerMPosX,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d{0,1}([.,]\d{0,2})?'),
                                    ),
                                  ],
                                  onSubmitted: (String value) {
                                    setState(() {
                                      widget.storedData.mintPosition[0] = (
                                          double.tryParse(
                                              value.replaceAll(',', '.'))!);
                                    });
                                  },
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: const TextStyle(
                                    fontFamily: 'Mukta',
                                    fontSize: 18,
                                  ),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: "0,00",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Mukta',
                                        fontSize: 18,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                              const Text(
                                "m",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Text(
                                "y: ",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: dividerColor),
                                ),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                                margin:
                                const EdgeInsets.symmetric(horizontal: 3),
                                child: TextField(
                                  controller: controllerBPosY,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d{0,1}([.,]\d{0,2})?'),
                                    ),
                                  ],
                                  onSubmitted: (String value) {
                                    setState(() {
                                      widget.storedData.blueberryPosition[1] = (
                                          double.tryParse(
                                              value.replaceAll(',', '.'))!);
                                    });
                                  },
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: const TextStyle(
                                    fontFamily: 'Mukta',
                                    fontSize: 18,
                                  ),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: "0,00",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Mukta',
                                        fontSize: 18,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                              const Text(
                                "m",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: <Widget>[
                              const Text(
                                "y: ",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: dividerColor),
                                ),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                                margin:
                                const EdgeInsets.symmetric(horizontal: 3),
                                child: TextField(
                                  controller: controllerIPosY,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d{0,1}([.,]\d{0,2})?'),
                                    ),
                                  ],
                                  onSubmitted: (String value) {
                                    setState(() {
                                      widget.storedData.icePosition[1] = (
                                          double.tryParse(
                                              value.replaceAll(',', '.'))!);
                                    });
                                  },
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: const TextStyle(
                                    fontFamily: 'Mukta',
                                    fontSize: 18,
                                  ),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: "0,00",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Mukta',
                                        fontSize: 18,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                              const Text(
                                "m",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: <Widget>[
                              const Text(
                                "y: ",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: dividerColor),
                                ),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                                margin:
                                const EdgeInsets.symmetric(horizontal: 3),
                                child: TextField(
                                  controller: controllerMPosY,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d{0,1}([.,]\d{0,2})?'),
                                    ),
                                  ],
                                  onSubmitted: (String value) {
                                    setState(() {
                                      widget.storedData.mintPosition[1] = (
                                          double.tryParse(
                                              value.replaceAll(',', '.'))!);
                                    });
                                  },
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: const TextStyle(
                                    fontFamily: 'Mukta',
                                    fontSize: 18,
                                  ),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: "0,00",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Mukta',
                                        fontSize: 18,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                              const Text(
                                "m",
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: fontColor1,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: dividerColor),
            Row(children: [
              const SizedBox(width: 10),
              Expanded(
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
                          child: const Text(
                            "(no disponible)",
                            style: TextStyle(
                              fontFamily: 'Mukta',
                              fontWeight: FontWeight.bold,
                              color: fontColor1,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ]),
              )
            ]),
            const Divider(color: dividerColor),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 40),
                  backgroundColor: primaryColor,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ))),
              onPressed: () {
                _saveCalibration();
                Navigator.pop(context);
              },
              child: const Text(
                "Guardar ajustes",
                style: TextStyle(
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.bold,
                  color: fontColor1,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ));
  }
}