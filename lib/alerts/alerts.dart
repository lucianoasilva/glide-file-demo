import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/colors.dart';

void showErrorToast(BuildContext context, String errorMessage) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: const BoxDecoration(
      color: Colors.red,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      gravity: ToastGravity.SNACKBAR);
}

void showErrorToastException(
    BuildContext context, String widgetName, Object exception) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: const BoxDecoration(
      color: Colors.red,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(
            "Excepción en widget $widgetName: ${exception.toString()}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 2),
    gravity: ToastGravity.SNACKBAR,
  );
}

void showErrorDialog(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            backgroundColor: tertiaryColor,
            title: Text(title,
                style: const TextStyle(
                  fontFamily: 'Mukta',
                  color: fontColor1,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                )),
            content: Text(message,
                style: const TextStyle(
                  fontFamily: 'Mukta',
                  color: fontColor1,
                  fontWeight: FontWeight.w100,
                  fontSize: 16,
                )),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 40),
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ))),
                child: const Text(
                  "Cerrar",
                  style: TextStyle(
                    fontFamily: 'Mukta',
                    color: fontColor1,
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

void showAlertDialog(BuildContext context, String title, String message,
    Function()? onPressed, String buttonText) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            backgroundColor: tertiaryColor,
            title: Text(title,
                style: const TextStyle(
                  fontFamily: 'Mukta',
                  color: fontColor1,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                )),
            content: Text(message,
                style: const TextStyle(
                  fontFamily: 'Mukta',
                  color: fontColor1,
                  fontWeight: FontWeight.w100,
                  fontSize: 16,
                )),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 40),
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ))),
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontFamily: 'Mukta',
                    color: fontColor1,
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ));
}
