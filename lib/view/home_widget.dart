import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

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
      }
      bool photos = await Permission.photos.status.isGranted;
      if (!photos) {
        print(
            "HOME WIDGET :::: no se garantizó el permiso de lectura de fotos.");
      }
    } else {
      bool storage = await Permission.storage.status.isGranted;
      if (!storage) {
        print("HOME WIDGET :::: no se garantizó el permiso de almacenamiento.");
      }
    }
  }

  Future<void> _loadCalibration() async {}

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
        body: HomeHeader());
  }
}
