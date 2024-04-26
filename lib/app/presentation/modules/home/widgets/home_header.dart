import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../config/colors.dart';
import '../../../controllers/controllers.dart';
import '../../alerts/alerts.dart';
import '../../configuration/configuration_screen.dart';
import '../../receive/screens/receiving_screen.dart';
import '../../send/screens/selection_screen.dart';
import 'logo_name_widget.dart';
import 'button_widget.dart';
import 'button_label_text.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final controller = Get.find<RequirementStateController>();
  StreamSubscription<BluetoothState>? _streamBluetooth;

  late PlatformFile pickedFile;

  @override
  void initState() {
    super.initState();
    listeningBluetoothState();
  }

  listeningBluetoothState() async {
    print('HOME HEADER WIDGET :::: Listening to bluetooth state');
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      controller.updateBluetoothState(state);
    });
    await flutterBeacon.requestAuthorization;
  }

  Future<bool> checkAllRequirements() async {
    final bluetoothState = await flutterBeacon.bluetoothState;
    controller.updateBluetoothState(bluetoothState);
    print('HOME HEADER WIDGET :::: BLUETOOTH $bluetoothState');

    final authorizationStatus = await flutterBeacon.authorizationStatus;
    controller.updateAuthorizationStatus(authorizationStatus);
    print('HOME HEADER WIDGET :::: AUTHORIZATION $authorizationStatus');

    final locationServiceEnabled =
        await flutterBeacon.checkLocationServicesIfEnabled;
    controller.updateLocationService(locationServiceEnabled);
    print('HOME HEADER WIDGET :::: LOCATION SERVICE $locationServiceEnabled');

    if (controller.bluetoothEnabled &&
        controller.authorizationStatusOk &&
        controller.locationServiceEnabled) {
      print('HOME HEADER WIDGET :::: STATE READY');
      return Future.value(true);
    } else {
      print('HOME HEADER WIDGET :::: STATE NOT READY');
      return Future.value(false);
    }
  }

  Future<bool> _createFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result == null) {
        print("HOME HEADER WIDGET :::: ERROR: empty result");
        if (!context.mounted) return Future.value(false);
        showErrorToast(context, "Error de selección de archivo.");
        return Future.value(false);
      } else {
        pickedFile = result.files.single;
        return Future.value(true);
      }
    } catch (e) {
      print("HOME HEADER WIDGET :::: exception: $e");
      showErrorToastException(context, "HomeHeader (selección de archivo)", e);
      return Future.value(false);
    }
  }

  Future<void> _sendButton(BuildContext context) async {
    final requirementsChecked = await checkAllRequirements();
    if (!context.mounted) return;
    if (requirementsChecked) {
      final fileSelected = await _createFile(context);
      if (!context.mounted) return;
      if (fileSelected) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SelectionScreen()));
      } else {
        print("HOME HEADER :::: Error de selección de archivo.");
        showErrorToast(context, "No se pudo seleccionar el archivo.");
      }
    } else {
      print("HOME HEADER :::: Faltan requerimientos");
      showAlertDialog(context, 'Faltan requerimientos',
          'Se deben habilitar todos los requerimientos para el mapeo del dispositivo.',
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ConfigurationScreen()),
        );
      }, 'Abrir configuración');
    }
  }

  Future<void> _receiveButton(BuildContext context, bool isNotification) async {
    final requirementsChecked = await checkAllRequirements();
    if (!context.mounted) return;
    if (requirementsChecked) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ReceivingScreen(notificationSwitch: isNotification)));
    } else {
      print("HOME HEADER :::: Faltan requerimientos");
      showAlertDialog(context, 'Faltan requerimientos',
          'Se deben habilitar todos los requerimientos para el mapeo del dispositivo.',
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ConfigurationScreen()),
        );
      }, 'Abrir configuración');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HomeHeader(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const LogoNameWidget(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 30),
                  ButtonWidget(
                    color: primaryColor,
                    iconButton: IconButton(
                      color: secondaryColor,
                      iconSize: 80,
                      icon: Image.asset('resources/icons/enviar.png',
                          color: secondaryColor),
                      onPressed: () => _sendButton(context),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const ButtonLabelText(text: 'Enviá'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ButtonLabelText(text: 'Recibí'),
                  const SizedBox(width: 20),
                  Builder(builder: (context) {
                    final configurationController =
                        Provider.of<ConfigurationController>(context);
                    return ButtonWidget(
                      color: secondaryColor,
                      iconButton: IconButton(
                        color: primaryColor,
                        iconSize: 80,
                        icon: Image.asset('resources/icons/recibir.png',
                            color: primaryColor),
                        onPressed: () => _receiveButton(
                          context,
                          configurationController.notificationSwitch,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    //Propiedades
    paint.color = primaryColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 20;

    final path = Path();

    //Dibujo
    path.lineTo(0.0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.75, size.width, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    //Dibujar
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
