class Wind {
  final double speed;

  final int deg;

  const Wind([this.speed = 0, this.deg = 0]);

  factory Wind.fromJson(dynamic json) {
    if (json == null) {
      return Wind();
    }

    return Wind(double.parse(json["speed"].toString()), json["deg"]);
  }
}
