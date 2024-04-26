import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../../config/colors.dart';
import '../../../controllers/controllers.dart';
import '../../alerts/alerts.dart';
import 'general_configuration_row.dart';
import 'text_title.dart';

class GeneralConfigurationTile extends StatefulWidget {
  const GeneralConfigurationTile({super.key});

  @override
  State<GeneralConfigurationTile> createState() =>
      _GeneralConfigurationTileState();
}

class _GeneralConfigurationTileState extends State<GeneralConfigurationTile> {
  final controller = Get.find<RequirementStateController>();
  StreamSubscription<BluetoothState>? _streamBluetooth;

  bool bluetoothSwitch = false;
  bool locationSwitch = false;

  @override
  void initState() {
    super.initState();
    _updateAllSwitches();
  }

  @override
  void dispose() {
    _streamBluetooth?.cancel();
    super.dispose();
  }

  _updateAllSwitches() async {
    await _updateBluetoothSwitch();
    await _updateLocationSwitch();
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
    print('CL F :::: Listening to bluetooth state');
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
        print("CONFIGURATION SCREEN :::: exception: $e");
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
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tertiaryColor,
      title: const TextTitle(text: 'General'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralConfigurationRow(
            title: 'Bluetooth',
            circleColor: Colors.blue,
            icon: Icons.bluetooth,
            configurationSwitch: Switch(
              value: bluetoothSwitch,
              onChanged: (value) async {
                _handleBluetooth(value);
              },
              activeColor: primaryColor,
              inactiveTrackColor: dividerColor,
            ),
          ),
          GeneralConfigurationRow(
            title: 'Ubicación',
            circleColor: Colors.red,
            icon: Icons.location_on,
            configurationSwitch: Switch(
              value: locationSwitch,
              onChanged: (value) async {
                _handleOpenLocationSettings();
              },
              activeColor: primaryColor,
              inactiveTrackColor: dividerColor,
            ),
          ),
          Builder(builder: (context) {
            final configurationController =
                Provider.of<ConfigurationController>(context);
            return GeneralConfigurationRow(
              title: 'Notificaciones',
              circleColor: Colors.green,
              icon: Icons.notifications_active,
              configurationSwitch: Switch(
                value: configurationController.notificationSwitch,
                onChanged: (value) {
                  setState(() {
                    configurationController.setNotificationSwitch(value);
                  });
                },
                activeColor: primaryColor,
                inactiveTrackColor: dividerColor,
              ),
            );
          }),
        ],
      ),
    );
  }
}
