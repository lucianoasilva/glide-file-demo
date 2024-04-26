import 'package:flutter/foundation.dart';

class StoredDataController extends ChangeNotifier {
  List<double> _blueberryPosition = [0.0, 0.0];
  List<double> _icePosition = [0.0, 0.0];
  List<double> _mintPosition = [0.0, 0.0];

  List<double> _tempBlueberryPosition = [0.0, 0.0];
  List<double> _tempIcePosition = [0.0, 0.0];
  List<double> _tempMintPosition = [0.0, 0.0];

  List<double> get blueberryPosition => _blueberryPosition;

  List<double> get icePosition => _icePosition;

  List<double> get mintPosition => _mintPosition;

  void updateAllPositions(
    List<double> blueberryPosition,
    List<double> icePosition,
    List<double> mintPosition,
  ) {
    _blueberryPosition = blueberryPosition;
    _icePosition = icePosition;
    _mintPosition = mintPosition;

    notifyListeners();
  }

  double getSpecificPosition(int beaconNumber, int axis) {
    switch (beaconNumber) {
      case 0:
        return _blueberryPosition[axis];
      case 1:
        return _icePosition[axis];
      case 2:
        return _mintPosition[axis];
      case _:
        print(
            "STORED DATA CONTROLLER :::: default case in updateSpecificPosition()");
    }
    return -1;
  }

  void updateSpecificPosition(int beaconNumber, int axis, double value) {
    switch (beaconNumber) {
      case 0:
        _blueberryPosition[axis] = value;
      case 1:
        _icePosition[axis] = value;
      case 2:
        _mintPosition[axis] = value;
      case _:
        print(
            "STORED DATA CONTROLLER :::: default case in updateSpecificPosition()");
    }

    notifyListeners();
  }

  void updateSpecificTempPosition(int beaconNumber, int axis, double value) {
    switch (beaconNumber) {
      case 0:
        _tempBlueberryPosition[axis] = value;
      case 1:
        _tempIcePosition[axis] = value;
      case 2:
        _tempMintPosition[axis] = value;
      case _:
        print(
            "STORED DATA CONTROLLER :::: default case in updateSpecificPosition()");
    }

    notifyListeners();
  }

  void updatePositionFromTemp() {
    _blueberryPosition = _tempBlueberryPosition;
    _icePosition = _tempIcePosition;
    _mintPosition = _tempMintPosition;

    notifyListeners();
  }

  void resetAllPositions() {
    _blueberryPosition = [0.0, 0.0];
    _icePosition = [0.0, 0.0];
    _mintPosition = [0.0, 0.0];

    notifyListeners();
  }

  void resetBlueberryPosition() {
    _blueberryPosition = [0.0, 0.0];

    notifyListeners();
  }

  void resetIcePosition() {
    _icePosition = [0.0, 0.0];

    notifyListeners();
  }

  void resetMintPosition() {
    _mintPosition = [0.0, 0.0];

    notifyListeners();
  }
}
