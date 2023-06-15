class Coords {
  final double lon;

  final double lat;

  const Coords([this.lon = 0, this.lat = 0]);

  factory Coords.fromJson(dynamic json) {
    if (json == null) {
      return Coords();
    }
    return Coords(json["lon"], json["lat"]);
  }
}
