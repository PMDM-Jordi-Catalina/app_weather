import 'package:tiempo_app/src/model/clouds.dart';
import 'package:tiempo_app/src/model/coords.dart';
import 'package:tiempo_app/src/model/main_weather.dart';
import 'package:tiempo_app/src/model/sys.dart';
import 'package:tiempo_app/src/model/weather.dart';
import 'package:tiempo_app/src/model/wind.dart';

class currentWeatherData {
  final Coords coords;
  final List<Weather> weather;
  final String base;
  final MainWeather mainWeather;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  static const Coords coordsOptional = Coords();
  static const MainWeather mainWeatherOptional = MainWeather();
  static const Clouds cloudsOptional = Clouds();
  static const Wind windOptional = Wind();
  static const Sys sysOptional = Sys();
  static const List<Weather> weatherOptional = [];

  currentWeatherData(
      [this.coords = coordsOptional,
      this.weather = weatherOptional,
      this.base = "",
      this.mainWeather = mainWeatherOptional,
      this.visibility = 0,
      this.wind = windOptional,
      this.clouds = cloudsOptional,
      this.dt = 0,
      this.sys = sysOptional,
      this.timezone = 0,
      this.id = 0,
      this.name = "",
      this.cod = 0]);

  factory currentWeatherData.fromJson(dynamic json) {
    if (json == null) {
      return currentWeatherData();
    }

    return currentWeatherData(
        Coords.fromJson(json['coord']),
        (json["weather"] as List).map((e) => Weather.fromJson(e)).toList(),
        json["base"],
        MainWeather.fromJson(json["main"]),
        json["visibility"],
        Wind.fromJson(json["wind"]),
        Clouds.fromJson(json["clouds"]),
        json["dt"],
        Sys.fromJson(json["sys"]),
        json["timezone"],
        json["id"],
        json["name"],
        json["cod"]);
  }
}
