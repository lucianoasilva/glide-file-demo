import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: secondaryColor,
            elevation: 0.0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: fontColor1,
                ),
              ),
            ],
          ),
        ),
        body: HomeHeader());
  }
}
