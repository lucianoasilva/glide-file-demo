import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../alerts/alerts.dart';
import 'sending_screen.dart';
import 'widgets/selection_background_widget.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  //Vertical drag details
  DragStartDetails? startVerticalDragDetails;
  DragUpdateDetails? updateVerticalDragDetails;

  //Horizontal drag details
  DragStartDetails? startHorizontalDragDetails;
  DragUpdateDetails? updateHorizontalDragDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Material(
        color: secondaryColor,
        child: Column(
          children: [
            Expanded(
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
              ),
            ),
            SelectionBackgroundWidget(),
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
            MaterialPageRoute(builder: (context) => const SendingScreen()),
          );
        } else {
          print("SELECTION SCREEN :::: update/start vertical null");
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
            MaterialPageRoute(builder: (context) => const SendingScreen()),
          );
        } else {
          print("SELECTION SCREEN :::: update/start horizontal null");
          showErrorToast(context, "Error de deslizamiento horizontal.");
        }
      },
    );
  }
}
