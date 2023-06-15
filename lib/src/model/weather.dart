class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  const Weather(
      [this.id = 0, this.main = "", this.description = "", this.icon = ""]);

  factory Weather.fromJson(dynamic json) {
    if (json == null) {
      return Weather();
    }

    return Weather(json["id"], json["main"], json["description"], json["icon"]);
  }
}
