import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../alerts/alerts.dart';
import '../controller/calibration_controller.dart';
import '../data/stored_data.dart';
import '../view/configuration_widget.dart';
import '../styles/colors.dart';
import '../widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StoredData storedData = StoredData();

  bool calibrationSwitch = true;
  bool notificationSwitch = true;

  double allowableRange = 20.0;

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  @override
  void initState() {
    super.initState();

    _initPermissions();

    if (calibrationSwitch) {
      _loadCalibration();
    }
  }

  _initPermissions() {
    Future.doWhile(() async {
      PermissionStatus bluetoothConnect =
          await Permission.bluetoothConnect.request();
      PermissionStatus bluetooth = await Permission.bluetooth.request();

      if (bluetooth == PermissionStatus.granted) {
        if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
          return false;
        }
        await Future.delayed(const Duration(microseconds: 0xDD));
        return true;
      } else {
        return false;
      }
    }).then((_) {
      FlutterBluetoothSerial.instance.name.then((name) {
        setState(() {
          print("HOME WIDGET :::: nameFBtS = $name");
        });
      });

      _initStoragePermissions();
    });
  }

  _initStoragePermissions() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      bool videos = await Permission.videos.status.isGranted;
      if (!videos) {
        print(
            "HOME WIDGET :::: no se garantizó el permiso de lectura de videos.");
        if (!context.mounted) return;
        showErrorToast(context,
            "Lectura de videos no permitido. Intenta habilitarlo manualmente.");
      }
      bool photos = await Permission.photos.status.isGranted;
      if (!photos) {
        print(
            "HOME WIDGET :::: no se garantizó el permiso de lectura de fotos.");
        if (!context.mounted) return;
        showErrorToast(context,
            "Lectura de fotos no permitido. Intenta habilitarlo manualmente.");
      }
    } else {
      bool storage = await Permission.storage.status.isGranted;
      if (!storage) {
        print("HOME WIDGET :::: no se garantizó el permiso de almacenamiento.");
        if (!context.mounted) return;
        showErrorToast(context,
            "No tenés permisos de almacenamiento. Intenta habilitarlo manualmente.");
      }
    }
  }

  Future<void> _loadCalibration() async {
    try {
      final calibration = await CalibrationController.loadCalibration();
      if (calibration != null) {
        storedData.blueberryPosition[0] = calibration.blueberryPositionX;
        storedData.blueberryPosition[1] = calibration.blueberryPositionY;
        storedData.icePosition[0] = calibration.icePositionX;
        storedData.icePosition[1] = calibration.icePositionY;
        storedData.mintPosition[0] = calibration.mintPositionX;
        storedData.mintPosition[1] = calibration.mintPositionY;
      } else {
        print("HOME WIDGET :::: archivo de calibración no existe");
        if (!context.mounted) return;
        showErrorToast(
            context, "Configuración anterior de beacons no disponible.");
      }
    } catch (e) {
      print("HOME WIDGET :::: excepción: $e");
      if (!context.mounted) return;
      showErrorToastException(context, 'Home (carga de calibración)', e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: secondaryColor,
            elevation: 0.0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfigurationWidget(
                                storedData: storedData,
                                calibrationSwitch: calibrationSwitch,
                                notificationSwitch: notificationSwitch,
                                allowableRange: allowableRange,
                                configurationCallback:
                                    (calSwitch, notSwitch, tolerance) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) => setState(() {
                                            calibrationSwitch = calSwitch;
                                            notificationSwitch = notSwitch;
                                            allowableRange = tolerance;
                                          }));
                                },
                              )));
                },
                icon: const Icon(
                  Icons.settings,
                  color: fontColor1,
                ),
              ),
            ],
          ),
        ),
        body: HomeHeader(
          storedData: storedData,
          calibrationSwitch: calibrationSwitch,
          notificationSwitch: notificationSwitch,
          allowableRange: allowableRange,
          configurationCallback: (calSwitch, notSwitch, tolerance) {
            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                  calibrationSwitch = calSwitch;
                  notificationSwitch = notSwitch;
                  allowableRange = tolerance;
                }));
          },
        ));
  }
}
