import 'dart:convert';

class WeatherData {
  String name;
  String main;
  String icon;
  double temp;

  WeatherData({
    required this.name,
    required this.temp,
    required this.main,
    required this.icon,
  });

  // Factory method untuk mendeserialisasi JSON ke WeatherData
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      name: json['name'] ?? '',
      temp: (json['main']['temp'] as num).toDouble(),
      main: json['weather'][0]['main'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
    );
  }

  // Method untuk mendeserialisasi dari string JSON
  static WeatherData deserialize(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return WeatherData.fromJson(jsonMap);
  }
}
