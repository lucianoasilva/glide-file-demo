import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view/received_widget.dart';
import '../styles/colors.dart';

class ReceivingWidget extends StatefulWidget {
  const ReceivingWidget({super.key});

  @override
  State<ReceivingWidget> createState() => _ReceivingWidgetState();
}

class _ReceivingWidgetState extends State<ReceivingWidget> {
  bool receiving = false;

  double progress = 0.0;

  static String defaultPath = '/storage/emulated/0/Documents/glide-file-demo';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        receiving = true;
        _startLoading();
      });
    });
  }

  void _startLoading() async {
    await _saveFileExample();
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      setState(() {
        progress += 0.01;
      });
      if (progress >= 1.0) {
        timer.cancel();
        setState(() {
          if (!context.mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ReceivedWidget()),
          );
        });
      }
    });
  }

  _saveFileExample() async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      Directory defaultDirectory = Directory(defaultPath);
      if (!(await defaultDirectory.exists())) {
        Directory newFolder = await defaultDirectory.create(recursive: true);
        defaultPath = newFolder.path;
        print("RECEIVING WIDGET :::: Directorio creado : $defaultPath");
      }

      String filePath = '$defaultPath/exampleImage.jpg';
      File receivedFileExample = File(filePath);

      if (await receivedFileExample.exists()) {
        print(
            "RECEIVING WIDGET :::: Imagen de ejemplo ya existe en el almacenamiento");
      } else {
        ByteData data =
            await rootBundle.load('resources/images/exampleImage.jpg');
        List<int> bytes = data.buffer.asUint8List();

        await receivedFileExample.writeAsBytes(bytes);
        print("RECEIVING WIDGET :::: Imagen de ejemplo guardada");
      }
    } catch (e) {
      print("RECEIVING WIDGET :::: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: secondaryColor,
        child: Column(children: <Widget>[
          Expanded(
            child: Align(
              alignment: const Alignment(0, 0),
              child: Text(
                (receiving) ? "Recibiendo..." : "Esperando...",
                style: const TextStyle(
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.bold,
                  color: fontColor1,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: const Alignment(0, -2),
              child: SizedBox(
                width: 200.0,
                height: 200.0,
                child: Stack(fit: StackFit.expand, children: [
                  CircularProgressIndicator(
                    value: (receiving) ? progress : null,
                    valueColor: const AlwaysStoppedAnimation(primaryColor),
                    color: primaryColor,
                    backgroundColor: primaryColorLight,
                    strokeWidth: 15.0,
                  ),
                  Center(
                      child: (receiving)
                          ? Text(
                              '${(progress * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontFamily: 'Mukta',
                                fontWeight: FontWeight.bold,
                                color: fontColor1,
                                fontSize: 30,
                              ),
                            )
                          : null),
                ]),
              ),
            ),
          ),
        ]));
  }
}
