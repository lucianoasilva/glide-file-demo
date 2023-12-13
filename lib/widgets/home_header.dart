import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';

import '../data/stored_data.dart';
import '../alerts/alerts.dart';
import '../controller/requirement_state_controller.dart';
import '../view/configuration_widget.dart';
import '../view/receiving_widget.dart';
import '../view/selection_widget.dart';
import '../styles/colors.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader(
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

  Future<bool> _createFile() async {
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
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 170,
                    child: Image.asset('resources/icons/glide-file_logo.png',
                        color: primaryColor),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Glide-File',
                        style: TextStyle(
                          fontFamily: 'LobsterTwo',
                          color: fontColor1,
                          fontStyle: FontStyle.italic,
                          fontSize: 50,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color:
                              primaryColor, // Puedes cambiar el color del rectángulo según tus preferencias
                        ),
                        child: const Text(
                          'Front Demo',
                          style: TextStyle(
                            fontFamily: 'Mukta',
                            color: fontColor1,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 30),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Container(
                      height: 100,
                      color: primaryColor,
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                          color: secondaryColor,
                          iconSize: 80,
                          icon: Image.asset('resources/icons/enviar.png',
                              color: secondaryColor),
                          onPressed: () async {
                            final requirementsChecked =
                                await checkAllRequirements();
                            if (!context.mounted) return;
                            if (requirementsChecked) {
                              final fileSelected = await _createFile();
                              if (!context.mounted) return;
                              if (fileSelected) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectionWidget()));
                              } else {
                                print(
                                    "HOME HEADER :::: Error de selección de archivo.");
                                showErrorToast(context,
                                    "No se pudo seleccionar el archivo.");
                              }
                            } else {
                              print("HOME HEADER :::: Faltan requerimientos");
                              showAlertDialog(context, 'Faltan requerimientos',
                                  'Se deben habilitar todos los requerimientos para el mapeo del dispositivo.',
                                  () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConfigurationWidget(
                                          storedData: widget.storedData,
                                          calibrationSwitch:
                                              widget.calibrationSwitch,
                                          notificationSwitch:
                                              widget.notificationSwitch,
                                          allowableRange: widget.allowableRange,
                                          configurationCallback: (calSwitch,
                                              notSwitch, tolerance) {
                                            widget.configurationCallback(
                                                calSwitch,
                                                notSwitch,
                                                tolerance);
                                          })),
                                );
                              }, 'Abrir configuración');
                            }
                          }),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Enviá',
                    style: TextStyle(
                      fontFamily: 'Mukta',
                      color: fontColor1,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Recibí',
                    style: TextStyle(
                      fontFamily: 'Mukta',
                      color: fontColor1,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(width: 20),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Container(
                      height: 100,
                      color: secondaryColor,
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                          color: primaryColor,
                          iconSize: 80,
                          icon: Image.asset('resources/icons/recibir.png',
                              color: primaryColor),
                          onPressed: () async {
                            final requirementsChecked =
                                await checkAllRequirements();
                            if (!context.mounted) return;
                            if (requirementsChecked) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReceivingWidget(
                                          notificationSwitch:
                                              widget.notificationSwitch)));
                            } else {
                              print("HOME HEADER :::: Faltan requerimientos");
                              showAlertDialog(context, 'Faltan requerimientos',
                                  'Se deben habilitar todos los requerimientos para el mapeo del dispositivo.',
                                  () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConfigurationWidget(
                                          storedData: widget.storedData,
                                          calibrationSwitch:
                                              widget.calibrationSwitch,
                                          notificationSwitch:
                                              widget.notificationSwitch,
                                          allowableRange: widget.allowableRange,
                                          configurationCallback: (calSwitch,
                                              notSwitch, tolerance) {
                                            widget.configurationCallback(
                                                calSwitch,
                                                notSwitch,
                                                tolerance);
                                          })),
                                );
                              }, 'Abrir configuración');
                            }
                          }),
                    ),
                  ),
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
