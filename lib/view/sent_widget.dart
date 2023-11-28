import 'package:flutter/material.dart';

import '../styles/colors.dart';

class SentWidget extends StatefulWidget {
  const SentWidget({super.key});

  @override
  State<SentWidget> createState() => _SentWidgetState();
}

class _SentWidgetState extends State<SentWidget> {
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
      child: Column(children: <Widget>[
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
      ]),
    );
  }
}
