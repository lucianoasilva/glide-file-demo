import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glide_file_demo/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:flutter/services.dart';

import 'app/data/services/notification_services.dart';
import 'app/presentation/config/colors.dart';
import 'app/presentation/controllers/controllers.dart';
import 'app/presentation/modules/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RequirementStateController());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StoredDataController()),
        ChangeNotifierProvider(create: (_) => ConfigurationController()),
      ],
      child: MaterialApp(
        title: 'Glide-File Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen.navigate(
          name: 'lib/app/resources/splash/splash.riv',
          next: (context) => const HomeScreen(),
          until: () => Future.delayed(const Duration(seconds: 3)),
          startAnimation: 'Splash',
          backgroundColor: secondaryColor,
        ),
      ),
    );
  }
}
