import 'package:flutter/material.dart';

import '../../config/colors.dart';
import 'widgets/configuration_widgets.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(
            fontFamily: 'Mukta',
            fontWeight: FontWeight.bold,
            color: fontColor1,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: secondaryColor,
      ),
      backgroundColor: secondaryColor,
      body: ListView(
        children: const [
          GeneralConfigurationTile(),
          Divider(height: 15),
          OrientationConfigurationTile(),
          Divider(height: 15),
          BeaconsConfigurationTile(),
          Divider(height: 15),
          ToleranceConfigurationTile(),
        ],
      ),
    );
  }
}
