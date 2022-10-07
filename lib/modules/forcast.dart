import 'dart:convert';
import 'package:http/http.dart' as http;

class ForCastApi {
  Future<Forecast?> getCurrentForecast(String? location) async {
    var uri = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&APPID=0cf5dd4b9fbfc5152d26d70559f66ac9");
    // api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=0cf5dd4b9fbfc5152d26d70559f66ac9

    var response = await http.get(uri);
    var body = jsonDecode(response.body);

    return Forecast.fromJson(body);
  }
}

class Forecast {
  final String city;
  final double temp;
  final double feelslike;
  final String description;
  final int humidity;
  final double wind;
  Forecast(
      {required this.city,
      required this.temp,
      required this.feelslike,
      required this.description,
      required this.humidity,
      required this.wind});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
        city: json["name"] as String,
        temp: json["main"]["temp"] as double,
        feelslike: json["main"]["feels_like"] as double,
        description: json["weather"][0]["description"] as String,
        humidity: json["main"]["humidity"] as int,
        wind: json["wind"]["speed"] as double);
  }
}
