import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/notification_services.dart';
import '../controller/requirement_state_controller.dart';
import '../view/home_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RequirementStateController());

    return MaterialApp(
        title: 'Glide-File Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}
