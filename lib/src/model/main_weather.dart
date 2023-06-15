class MainWeather {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  const MainWeather(
      [this.temp = 0,
      this.feelsLike = 0,
      this.tempMin = 0,
      this.tempMax = 0,
      this.pressure = 0,
      this.humidity = 0]);

  factory MainWeather.fromJson(dynamic json) {
    if (json == null) {
      return MainWeather();
    }

    return MainWeather(json["temp"], json["feels_like"], json["temp_min"],
        json["temp_max"], json["pressure"], json["humidity"]);
  }
}
