class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  const Sys(
      [this.type = 0,
      this.id = 0,
      this.country = "",
      this.sunrise = 0,
      this.sunset = 0]);

  factory Sys.fromJson(dynamic json) {
    if (json == null) {
      return Sys();
    }

    return Sys(json["type"], json["id"], json["country"], json["sunrise"],
        json["sunset"]);
  }
}
