import 'package:flutter/material.dart';

import '../data/stored_data.dart';
import '../view/calibration_widget.dart';
import '../styles/colors.dart';

class ConfigurationWidget extends StatefulWidget {
  const ConfigurationWidget({super.key, required this.storedData});

  final StoredData storedData;

  @override
  State<ConfigurationWidget> createState() => _ConfigurationWidgetState();
}

class _ConfigurationWidgetState extends State<ConfigurationWidget> {
  bool bluetoothSwitch = false;
  bool locationSwitch = false;
  bool notificationSwitch = true;
  bool calibrationSwitch = true;

  double allowableRange = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Configuración",
          style: TextStyle(
            fontFamily: 'Mukta',
            fontWeight: FontWeight.bold,
            color: fontColor1,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: secondaryColor,
      ),
      backgroundColor: secondaryColor,
      body: ListView(
        children: <Widget>[
          ListTile(
            tileColor: tertiaryColor,
            title: const Text(
              "General",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Row(
                      children: [
                        SizedBox(width: 30),
                        CircleAvatar(
                          child: Icon(Icons.bluetooth),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Bluetooth",
                          style: TextStyle(
                            fontFamily: 'Mukta',
                            fontWeight: FontWeight.w100,
                            color: fontColor1,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: bluetoothSwitch,
                      onChanged: (value) {
                        setState(() {
                          bluetoothSwitch = value;
                        });
                      },
                      activeColor: primaryColor,
                      inactiveTrackColor: dividerColor,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Row(
                      children: [
                        SizedBox(width: 30),
                        CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Ubicación",
                          style: TextStyle(
                            fontFamily: 'Mukta',
                            fontWeight: FontWeight.w100,
                            color: fontColor1,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: locationSwitch,
                      onChanged: (value) {
                        setState(() {
                          locationSwitch = value;
                        });
                      },
                      activeColor: primaryColor,
                      inactiveTrackColor: dividerColor,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Row(
                      children: [
                        SizedBox(width: 30),
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.notifications_active,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Notificaciones",
                          style: TextStyle(
                            fontFamily: 'Mukta',
                            fontWeight: FontWeight.w100,
                            color: fontColor1,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: notificationSwitch,
                      onChanged: (value) {
                        setState(() {
                          notificationSwitch = value;
                        });
                      },
                      activeColor: primaryColor,
                      inactiveTrackColor: dividerColor,
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 15),
          ListTile(
            tileColor: tertiaryColor,
            title: const Text(
              "Orientación",
              style: TextStyle(
                fontFamily: 'Mukta',
                color: fontColor1,
                fontSize: 20,
              ),
            ),
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
          ),
          const Divider(height: 15),
          ListTile(
            tileColor: tertiaryColor,
            title: const Text(
              "Beacons",
              style: TextStyle(
                fontFamily: 'Mukta',
                fontWeight: FontWeight.bold,
                color: fontColor1,
                fontSize: 20,
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Usar la configuración anterior",
                      style: TextStyle(
                        fontFamily: 'Mukta',
                        fontWeight: FontWeight.w100,
                        color: fontColor1,
                        fontSize: 18,
                      ),
                    ),
                    Switch(
                      value: calibrationSwitch,
                      onChanged: (value) {
                        setState(() {
                          calibrationSwitch = value;
                        });
                      },
                      activeColor: primaryColor,
                      inactiveTrackColor: dividerColor,
                    )
                  ],
                ),
                (!calibrationSwitch)
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
                          "Configurar",
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
                                  builder: (context) => CalibrationWidget(
                                      storedData: widget.storedData)));
                        },
                      )
                    : Container()
              ],
            ),
          ),
          const Divider(height: 15),
          ListTile(
            tileColor: tertiaryColor,
            title: const Text(
              "Tolerancia",
              style: TextStyle(
                fontFamily: 'Mukta',
                fontWeight: FontWeight.bold,
                color: fontColor1,
                fontSize: 20,
              ),
            ),
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
                Column(
                  children: <Widget>[
                    Text(
                      "${allowableRange.toStringAsFixed(0)}°",
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
                      value: allowableRange,
                      onChanged: (value) {
                        setState(() {
                          allowableRange = value;
                        });
                      },
                      activeColor: primaryColor,
                      inactiveColor: primaryColorLight,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
