import 'dart:convert';

import 'dart:convert';

class WeatherData {
  final String name;
  final double temp;
  final String icon;
  final String main;
  final double feelsLike;
  final double humidity;
  final double windSpeed;
  final double pressure;

  WeatherData({
    required this.name,
    required this.temp,
    required this.icon,
    required this.main,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });

  // Fungsi deserialize
  factory WeatherData.deserialize(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);

    return WeatherData(
      name: json['name'] ?? '',
      temp: (json['main']['temp'] ?? 0).toDouble(),
      icon: json['weather'][0]['icon'] ?? '',
      main: json['weather'][0]['main'] ?? '',
      feelsLike: (json['main']['feels_like'] ?? 0).toDouble(),
      humidity: (json['main']['humidity'] ?? 0).toDouble(),
      windSpeed: (json['wind']['speed'] ?? 0).toDouble(),
      pressure: (json['main']['pressure'] ?? 0).toDouble(),
    );
  }
}


class WeatherDescription {
  final String main;

  WeatherDescription({required this.main});

  factory WeatherDescription.fromJson(Map<String, dynamic> json) {
    return WeatherDescription(main: json['main']);
  }
}
