import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';

import '../../../config/colors.dart';
import '../../alerts/alerts.dart';

class ReceivedScreen extends StatefulWidget {
  const ReceivedScreen({super.key, required this.filePath});

  @override
  State<ReceivedScreen> createState() => _ReceivedScreenState();

  final String filePath;
}

class _ReceivedScreenState extends State<ReceivedScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      child: Column(
        children: [
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
                        print("RECEIVED SCREEN :::: openResult = $openResult");
                      });
                    } else {
                      print("RECEIVED SCREEN :::: No existe el archivo.");
                      if (!context.mounted) return;
                      showErrorToast(context, "El archivo no existe.");
                    }
                  } catch (e) {
                    print("RECEIVED SCREEN :::: excepción: $e");
                    showErrorToastException(
                        context, "Received (abrir archivo)", e);
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
        ],
      ),
    );
  }
}
