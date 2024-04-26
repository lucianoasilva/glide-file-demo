import 'package:flutter/foundation.dart';

class ConfigurationController extends ChangeNotifier {
  bool _calibrationSwitch = true;
  bool _notificationSwitch = true;
  double _allowableRange = 20.0;

  bool get calibrationSwitch => _calibrationSwitch;

  bool get notificationSwitch => _notificationSwitch;

  double get allowableRange => _allowableRange;

  void setCalibrationSwitch(bool value) {
    _calibrationSwitch = value;

    notifyListeners();
  }

  void setNotificationSwitch(bool value) {
    _notificationSwitch = value;

    notifyListeners();
  }

  void setAllowableRange(double value) {
    _allowableRange = value;

    notifyListeners();
  }

  void resetAllValues() {
    _calibrationSwitch = true;
    _notificationSwitch = true;
    _allowableRange = 20.0;

    notifyListeners();
  }
}
