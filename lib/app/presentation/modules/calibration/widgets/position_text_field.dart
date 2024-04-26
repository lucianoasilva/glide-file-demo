import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../config/colors.dart';
import '../../../controllers/stored_data_controller.dart';

class PositionTextField extends StatefulWidget {
  const PositionTextField({
    super.key,
    required this.beaconNumber,
    required this.axis,
  });

  final int beaconNumber;
  final int axis;

  @override
  State<PositionTextField> createState() => _PositionTextFieldState();
}

class _PositionTextFieldState extends State<PositionTextField> {
  bool isInit = true;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final storedDataController = Provider.of<StoredDataController>(context);
      if (isInit) {
        controller.text = storedDataController
            .getSpecificPosition(widget.beaconNumber, widget.axis)
            .toString();
        isInit = false;
      }
      return Container(
        width: 50,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: dividerColor),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d{0,1}([.,]\d{0,2})?'),
            ),
          ],
          onSubmitted: (text) {
            setState(() {
              double value = double.tryParse(text.replaceAll(',', '.'))!;
              storedDataController.updateSpecificTempPosition(
                  widget.beaconNumber, widget.axis, value);
            });
          },
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.bottom,
          style: const TextStyle(
            fontFamily: 'Mukta',
            fontSize: 18,
          ),
          decoration: const InputDecoration.collapsed(
              hintText: '0,00',
              hintStyle: TextStyle(
                fontFamily: 'Mukta',
                fontSize: 18,
              ),
              border: InputBorder.none),
        ),
      );
    });
  }
}
