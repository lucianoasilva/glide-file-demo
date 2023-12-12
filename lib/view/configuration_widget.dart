import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';

import '../alerts/alerts.dart';
import '../controller/requirement_state_controller.dart';
import '../data/stored_data.dart';
import '../view/calibration_widget.dart';
import '../styles/colors.dart';

class ConfigurationWidget extends StatefulWidget {
  const ConfigurationWidget(
      {super.key,
      required this.storedData,
      required this.calibrationSwitch,
      required this.notificationSwitch,
      required this.allowableRange,
      required this.configurationCallback});

  final StoredData storedData;
  final bool calibrationSwitch;
  final bool notificationSwitch;
  final double allowableRange;
  final Function(bool, bool, double) configurationCallback;

  @override
  State<ConfigurationWidget> createState() => _ConfigurationWidgetState();
}

class _ConfigurationWidgetState extends State<ConfigurationWidget> {
  final controller = Get.find<RequirementStateController>();
  StreamSubscription<BluetoothState>? _streamBluetooth;

  bool bluetoothSwitch = false;
  bool locationSwitch = false;
  bool notificationSwitch = true;
  bool calibrationSwitch = true;

  double allowableRange = 20.0;

  @override
  void initState() {
    super.initState();
    allowableRange = widget.allowableRange;
    _updateAllSwitches();
  }

  _updateAllSwitches() async {
    await _updateBluetoothSwitch();
    await _updateLocationSwitch();
    setState(() {
      calibrationSwitch = widget.calibrationSwitch;
      notificationSwitch = widget.notificationSwitch;
    });
  }

  _updateBluetoothSwitch() async {
    await _listeningBluetoothState();
    final state = controller.bluetoothState.value;
    setState(() {
      if (state == BluetoothState.stateOn) {
        bluetoothSwitch = true;
      } else {
        bluetoothSwitch = false;
      }
    });
  }

  _updateLocationSwitch() async {
    await _listeningLocationState();
    setState(() {
      locationSwitch = controller.locationServiceEnabled;
    });
  }

  _listeningBluetoothState() async {
    print('CONFIGURATION WIDGET :::: Listening to bluetooth state');
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      controller.updateBluetoothState(state);
    });
    await flutterBeacon.requestAuthorization;
  }

  _listeningLocationState() async {
    final locationServiceEnabled =
        await flutterBeacon.checkLocationServicesIfEnabled;
    controller.updateLocationService(locationServiceEnabled);
  }

  _handleBluetooth(value) async {
    if (Platform.isAndroid) {
      try {
        await flutterBeacon.openBluetoothSettings;
      } on PlatformException catch (e) {
        print("CONFIGURATION WIDGET :::: exception: $e");
        showErrorToastException(context, "Configuration (Bluetooth)", e);
      } finally {
        await _updateBluetoothSwitch();
      }
    } else if (Platform.isIOS) {
      showErrorDialog(context, 'Bluetooth desactivado',
          'Activa Bluetooth en Ajustes > Bluetooth');
    }
  }

  _handleOpenLocationSettings() async {
    if (Platform.isAndroid) {
      await flutterBeacon.openLocationSettings;
      await _updateLocationSwitch();
    } else if (Platform.isIOS) {
      showErrorDialog(context, 'Servicio de localización desactivado',
          'Activalo en Ajustes > Privacidad > Servicio de localización');
    }
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null) {
        if (_streamBluetooth!.isPaused) {
          _streamBluetooth?.resume();
        }
      }
      _updateAllSwitches();
    } else if (state == AppLifecycleState.paused) {
      _streamBluetooth?.pause();
    }
  }

  @override
  void dispose() {
    _streamBluetooth?.cancel();
    widget.configurationCallback(
        calibrationSwitch, notificationSwitch, allowableRange);
    super.dispose();
  }

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
                      onChanged: (value) async {
                        _handleBluetooth(value);
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
                      onChanged: (value) async {
                        _handleOpenLocationSettings();
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
