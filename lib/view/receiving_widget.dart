import 'dart:async';

import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ReceivingWidget extends StatefulWidget {
  const ReceivingWidget({super.key});

  @override
  State<ReceivingWidget> createState() => _ReceivingWidgetState();
}

class _ReceivingWidgetState extends State<ReceivingWidget> {

  bool receiving = false;

  double progress = 0.0;

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

  void _startLoading() {
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      setState(() {
        progress += 0.01;
      });
      if (progress >= 1.0) {
        timer.cancel();
        setState(() {

        });
      }
    });
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
