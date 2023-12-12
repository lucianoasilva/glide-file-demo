import 'package:flutter/material.dart';

import '../view/sending_widget.dart';
import '../alerts/alerts.dart';
import '../styles/colors.dart';

class SelectionWidget extends StatefulWidget {
  const SelectionWidget({super.key});

  @override
  State<SelectionWidget> createState() => _SelectionWidgetState();
}

class _SelectionWidgetState extends State<SelectionWidget> {
  //Vertical drag details
  DragStartDetails? startVerticalDragDetails;
  DragUpdateDetails? updateVerticalDragDetails;

  //Horizontal drag details
  DragStartDetails? startHorizontalDragDetails;
  DragUpdateDetails? updateHorizontalDragDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        color: secondaryColor,
        child: Column(
          children: <Widget>[
            const Expanded(
                child: Align(
              child: Text(
                "¡Deslizá!",
                style: TextStyle(
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.bold,
                  color: fontColor1,
                  fontSize: 30,
                ),
              ),
            )),
            SizedBox(
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
                        )),
                  ],
                )),
          ],
        ),
      ),
      onVerticalDragStart: (dragDetails) {
        startVerticalDragDetails = dragDetails;
      },
      onVerticalDragUpdate: (dragDetails) {
        updateVerticalDragDetails = dragDetails;
      },
      onVerticalDragEnd: (endDetails) {
        if (updateVerticalDragDetails != null &&
            startVerticalDragDetails != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SendingWidget()),
          );
        } else {
          print("SELECTION WIDGET :::: update/start vertical null");
          showErrorToast(context, "Error de deslizamiento vertical");
        }
      },
      onHorizontalDragStart: (dragDetails) {
        startHorizontalDragDetails = dragDetails;
      },
      onHorizontalDragUpdate: (dragDetails) {
        updateHorizontalDragDetails = dragDetails;
      },
      onHorizontalDragEnd: (endDetails) {
        if (updateHorizontalDragDetails != null &&
            startHorizontalDragDetails != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SendingWidget()),
          );
        } else {
          print("SELECTION WIDGET :::: update/start horizontal null");
          showErrorToast(context, "Error de deslizamiento horizontal.");
        }
      },
    );
  }
}
