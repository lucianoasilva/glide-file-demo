class Calibration {
  double blueberryPositionX = 0.0;
  double blueberryPositionY = 0.0;
  double icePositionX = 0.0;
  double icePositionY = 0.0;
  double mintPositionX = 0.0;
  double mintPositionY = 0.0;

  Calibration(
      this.blueberryPositionX,
      this.blueberryPositionY,
      this.icePositionX,
      this.icePositionY,
      this.mintPositionX,
      this.mintPositionY);

  Calibration.fromJson(Map<String, dynamic> json)
      : blueberryPositionX = double.parse(json['blueberryPositionX']),
        blueberryPositionY = double.parse(json['blueberryPositionY']),
        icePositionX = double.parse(json['icePositionX']),
        icePositionY = double.parse(json['icePositionY']),
        mintPositionX = double.parse(json['mintPositionX']),
        mintPositionY = double.parse(json['mintPositionY']);

  Map<String, dynamic> toJson() => {
        'blueberryPositionX': blueberryPositionX.toString(),
        'blueberryPositionY': blueberryPositionY.toString(),
        'icePositionX': icePositionX.toString(),
        'icePositionY': icePositionY.toString(),
        'mintPositionX': mintPositionX.toString(),
        'mintPositionY': mintPositionY.toString(),
      };
}
