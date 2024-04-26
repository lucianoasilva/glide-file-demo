import 'package:flutter/material.dart';

class SelectionBackgroundWidget extends StatelessWidget {
  const SelectionBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: Stack(
        children: [
          Align(
              alignment: const Alignment(0, -0.5),
              child: Container(
                width: 160,
                height: 160,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 158, 36),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(-15, 30),
                    ),
                  ],
                ),
              )),
          Align(
              alignment: const Alignment(0, -0.8),
              child: Container(
                width: 240,
                height: 240,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(150, 255, 158, 36),
                  shape: BoxShape.circle,
                ),
              )),
          Align(
              alignment: const Alignment(0, -1.2),
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(80, 255, 158, 36),
                  shape: BoxShape.circle,
                ),
              )),
          Align(
            alignment: const Alignment(0, -2.3),
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                color: Color.fromARGB(20, 255, 158, 36),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
