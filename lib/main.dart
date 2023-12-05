import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/requirement_state_controller.dart';
import '../view/home_widget.dart';

void main() {
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
        home: HomePage()
    );
  }
}
