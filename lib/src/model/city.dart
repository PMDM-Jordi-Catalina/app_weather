import 'package:tiempo_app/src/model/coords.dart';

class City {
  final int id;

  final String name;

  final Coords coords;

  static const Coords coordsOptional = Coords();
  const City([this.id = 0, this.name = "", this.coords = coordsOptional]);

  factory City.fromJson(dynamic json) {
    if (json == null) {
      return City();
    }
    return City(json["id"], json["name"], Coords.fromJson(json["coord"]));
  }
}
