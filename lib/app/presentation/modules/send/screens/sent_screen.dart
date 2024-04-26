import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class SentScreen extends StatefulWidget {
  const SentScreen({super.key});

  @override
  State<SentScreen> createState() => _SentScreenState();
}

class _SentScreenState extends State<SentScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.green,
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment(0, 0),
              child: Text(
                "¡Enviado!",
                style: TextStyle(
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
                alignment: Alignment(0, -2),
                child: Icon(
                  Icons.check_rounded,
                  color: fontColor1,
                  size: 220,
                )),
          ),
        ],
      ),
    );
  }
}
