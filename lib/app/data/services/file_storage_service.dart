import 'dart:convert';
import 'dart:io';

import '../../domain/entity/calibration.dart';

class FileStorageService {
  static String defaultPath = '/storage/emulated/0/Documents/glide-file-demo';

  static Future<void> saveCalibration(Calibration calibration) async {
    try {
      //Verificación del directorio
      Directory defaultDirectory = Directory(defaultPath);
      if (!(await defaultDirectory.exists())) {
        Directory newFolder = await defaultDirectory.create(recursive: true);
        defaultPath = newFolder.path;
        print("FILE STORAGE SERVICE :::: Directorio creado : $defaultPath");
      }
      //Guardado del archivo
      String path = '$defaultPath/calibration.json';
      final file = File(path);
      final encodedCalibration = jsonEncode(calibration.toJson());
      await file.writeAsString(encodedCalibration);
      print("FILE STORAGE SERVICE :::: Archivo de calibración guardado.");
    } catch (e) {
      print("FILE STORAGE SERVICE :::: Excepción: $e");
      throw Exception(e);
    }
  }

  static Future<Calibration?> loadCalibration() async {
    try {
      //Verificación del directorio
      Directory defaultDirectory = Directory(defaultPath);
      if (!(await defaultDirectory.exists())) {
        print("FILE STORAGE SERVICE :::: No existe directorio $defaultPath");
        throw Exception("No existe el directorio $defaultPath");
      } else {
        String path = '$defaultPath/calibration.json';
        final file = File(path);
        if (!await file.exists()) {
          print("FILE STORAGE SERVICE :::: No existe archivo");
          throw Exception("El archivo no existe");
        }

        final jsonString = await file.readAsString();
        final decodedCalibration = jsonDecode(jsonString);

        return Calibration.fromJson(decodedCalibration);
      }
    } catch (e) {
      print("FILE STORAGE SERVICE :::: Excepción: $e");
      throw Exception(e);
    }
  }
}
