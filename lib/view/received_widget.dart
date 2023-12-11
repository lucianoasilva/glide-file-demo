import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';

import '../styles/colors.dart';

class ReceivedWidget extends StatefulWidget {
  const ReceivedWidget({super.key, required this.filePath});

  @override
  State<ReceivedWidget> createState() => _ReceivedWidgetState();

  final String filePath;
}

class _ReceivedWidgetState extends State<ReceivedWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      child: Column(children: <Widget>[
        const Expanded(
          child: Align(
            alignment: Alignment(0, 0),
            child: Text(
              "¡Recibido!",
              style: TextStyle(
                fontFamily: 'Mukta',
                fontWeight: FontWeight.bold,
                color: fontColor1,
                fontSize: 30,
              ),
            ),
          ),
        ),
        const Expanded(
          child: Align(
              alignment: Alignment(0, -2),
              child: Icon(
                Icons.check_rounded,
                color: fontColor1,
                size: 220,
              )),
        ),
        Expanded(
          child: Align(
            alignment: const Alignment(0, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(180, 50),
                  backgroundColor: fontColor1,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ))),
              onPressed: () async {
                try {
                  bool exists = await File(widget.filePath).exists();
                  if (exists) {
                    final result = await OpenFile.open(widget.filePath);
                    setState(() {
                      var openResult =
                          "type=${result.type} message=${result.message}";
                      print("RECEIVED WIDGET :::: openResult = $openResult");
                    });
                  } else {
                    print("RECEIVED WIDGET :::: No existe el archivo.");
                  }
                } catch (e) {
                  print("RECEIVED WIDGET :::: excepción: $e");
                }
              },
              child: const Text(
                "Abrir archivo",
                style: TextStyle(
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
