import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:tiempo_app/src/model/Forecast.dart';
import 'package:tiempo_app/src/model/current_weahter_data.dart';

class TiempoService {
  String baseUrl = "http://api.openweathermap.org/data/2.5";

  String apiKey = "appid=e4400f5c2b115bb7f6fb81d679f84c67";

  TiempoService();

  Future<currentWeatherData> getCurrentWheatherData(Position position) async {
    final url =
        "$baseUrl/weather?lat=${position.latitude}&lon=${position.longitude}&lang=en&$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return currentWeatherData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Forecast>> getFiveDays(Position position, String? ciudad) async {
    String url = "";
    if (ciudad == null) {
      url =
          "$baseUrl/forecast?lat=${position.latitude}&lon=${position.longitude}&lang=es&$apiKey";
    } else {
      url = "$baseUrl/forecast?q=$ciudad&lang=es&$apiKey";
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseDecode = jsonDecode(response.body);
      final responseList = responseDecode["list"] as List;
      final responseCity = responseDecode["city"];
      return responseList
          .map((data) => Forecast.fromJson(data, responseCity))
          .toList();
    } else {
      return [];
      // throw Exception('Failed to load album');
    }
  }

  void getTopFiveCities(
      Function() beforeSend,
      Function(dynamic currentWeatherData) onSucces,
      Function(dynamic error) onError) {}

  void getFiveDaysThreeHoursForcastData(
      Function() beforeSend,
      Function(dynamic currentWeatherData) onSucces,
      Function(dynamic error) onError) {}
}
