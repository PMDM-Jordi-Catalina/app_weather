import 'package:tiempo_app/src/model/city.dart';
import 'package:tiempo_app/src/model/clouds.dart';
import 'package:tiempo_app/src/model/main_weather.dart';
import 'package:tiempo_app/src/model/weather.dart';
import 'package:tiempo_app/src/model/wind.dart';

class Forecast {
  final int dt;
  final MainWeather main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final City city;
  final String dtTxt;

  static const City cityOptional = City();
  static const MainWeather mainWeatherOptional = MainWeather();
  static const Clouds cloudsOptional = Clouds();
  static const Wind windOptional = Wind();
  static const List<Weather> weatherOptional = [];

  Forecast(
      [this.dt = 0,
      this.main = mainWeatherOptional,
      this.weather = weatherOptional,
      this.clouds = cloudsOptional,
      this.wind = windOptional,
      this.visibility = 0,
      this.city = cityOptional,
      this.dtTxt = ""]);

  factory Forecast.fromJson(dynamic json, dynamic city) {
    if (json == null) {
      return Forecast();
    }

    return Forecast(
        json["dt"],
        MainWeather.fromJson(json["main"]),
        (json["weather"] as List).map((e) => Weather.fromJson(e)).toList(),
        Clouds.fromJson(json["clouds"]),
        Wind.fromJson(json["wind"]),
        json["visibility"],
        City.fromJson(city),
        json["dt_txt"]);
  }
}
