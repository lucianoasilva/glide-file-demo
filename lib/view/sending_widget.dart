import 'package:flutter/material.dart';

import '../view/sent_widget.dart';
import '../styles/colors.dart';

class SendingWidget extends StatefulWidget {
  const SendingWidget({super.key});

  @override
  State<SendingWidget> createState() => _SendingWidgetState();
}

class _SendingWidgetState extends State<SendingWidget> {
  String currentState = "initState";

  @override
  void initState() {
    super.initState();
    setState(() {
      _connect();
    });
  }

  void _connect() {
    currentState = "Conectando...";
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _sending();
      });
    });
  }

  void _sending() {
    currentState = "Enviando...";
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        if (!context.mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SentWidget()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: secondaryColor,
        child: Column(children: <Widget>[
          const Expanded(
            child: Align(
              alignment: Alignment(0, 0.5),
              child: Text(
                "Enviando...",
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
              child: SizedBox(
                width: 200.0,
                height: 200.0,
                child: CircularProgressIndicator(
                  color: primaryColor,
                  backgroundColor: primaryColorLight,
                  strokeWidth: 15.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: const Alignment(0, -0.5),
              child: Text(
                currentState,
                style: const TextStyle(
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.w100,
                  color: fontColor1,
                  fontSize: 14,
                ),
              ),
            ),
          )
        ]));
  }
}
