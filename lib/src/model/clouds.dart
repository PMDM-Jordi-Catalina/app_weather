class Clouds {
  final int all;

  const Clouds([this.all = 0]);

  factory Clouds.fromJson(dynamic json) {
    if (json == null) {
      return Clouds();
    }
    return Clouds(json["all"]);
  }
}
