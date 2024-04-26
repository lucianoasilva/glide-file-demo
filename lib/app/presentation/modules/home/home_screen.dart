import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

import '../../../data/services/file_storage_service.dart';
import '../../config/colors.dart';
import '../../controllers/controllers.dart';
import '../alerts/alerts.dart';
import '../configuration/configuration_screen.dart';
import 'widgets/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  @override
  void initState() {
    super.initState();

    _initPermissions();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final configurationController =
          Provider.of<ConfigurationController>(context, listen: false);
      if (configurationController.calibrationSwitch) {
        _loadCalibration();
      }
    });
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
          print("HOME SCREEN :::: nameFBtS = $name");
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
            "HOME SCREEN :::: no se garantizó el permiso de lectura de videos.");
        if (!context.mounted) return;
        showErrorToast(context,
            "Lectura de videos no permitido. Intenta habilitarlo manualmente.");
      }
      bool photos = await Permission.photos.status.isGranted;
      if (!photos) {
        print(
            "HOME SCREEN :::: no se garantizó el permiso de lectura de fotos.");
        if (!context.mounted) return;
        showErrorToast(context,
            "Lectura de fotos no permitido. Intenta habilitarlo manualmente.");
      }
    } else {
      bool storage = await Permission.storage.status.isGranted;
      if (!storage) {
        print("HOME SCREEN :::: no se garantizó el permiso de almacenamiento.");
        if (!context.mounted) return;
        showErrorToast(context,
            "No tenés permisos de almacenamiento. Intenta habilitarlo manualmente.");
      }
    }
  }

  Future<void> _loadCalibration() async {
    try {
      final calibration = await FileStorageService.loadCalibration();
      if (calibration != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          final storedDataController =
              Provider.of<StoredDataController>(context, listen: false);
          storedDataController.updateAllPositions(
            [calibration.blueberryPositionX, calibration.blueberryPositionY],
            [calibration.icePositionX, calibration.icePositionY],
            [calibration.mintPositionX, calibration.mintPositionY],
          );
        });
      } else {
        print("HOME SCREEN :::: archivo de calibración no existe");
        if (!context.mounted) return;
        showErrorToast(
            context, "Configuración anterior de beacons no disponible.");
      }
    } catch (e) {
      print("HOME SCREEN :::: excepción: $e");
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
                          builder: (context) => const ConfigurationScreen()));
                },
                icon: const Icon(
                  Icons.settings,
                  color: fontColor1,
                ),
              ),
            ],
          ),
        ),
        body: const HomeHeader());
  }
}
