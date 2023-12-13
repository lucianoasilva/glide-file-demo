import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('notification_icon');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showRNotification(int id) async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('01', 'Recepción de archivo',
      importance: Importance.max, priority: Priority.high);

  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);

  switch (id) {
    case 1:
      await flutterLocalNotificationsPlugin.show(
          1, 'Esperando...', 'Esperando conexión.', notificationDetails);
      break;
    case 2:
      await flutterLocalNotificationsPlugin.show(
          2, 'Recibiendo...', 'Recibiendo archivo.', notificationDetails);
      break;
    case 3:
      await flutterLocalNotificationsPlugin.show(
          3, '¡Recibido!', 'El archivo se ha recibido.', notificationDetails);
      break;
  }
}