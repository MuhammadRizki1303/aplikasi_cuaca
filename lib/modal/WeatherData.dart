import 'dart:convert';

class WeatherData {
  final String name;
  final String main;
  final double temp;
  final String icon;
  final double feelsLike; // Menambahkan feelsLike
  final List<WeatherDescription> weather;

  WeatherData({
    required this.name,
    required this.main,
    required this.temp,
    required this.icon,
    required this.feelsLike, // Inisialisasi feelsLike
    required this.weather,
  });

  // Fungsi deserialization untuk menerima JSON dari API
  factory WeatherData.deserialize(String jsonStr) {
    final Map<String, dynamic> json = jsonDecode(jsonStr);
    return WeatherData(
      name: json['name'],
      main: json['weather'][0]['main'],
      temp: json['main']['temp'],
      icon: json['weather'][0]['icon'],
      feelsLike: json['main']['feels_like'], // Menambahkan feelsLike
      weather: (json['weather'] as List)
          .map((e) => WeatherDescription.fromJson(e))
          .toList(),
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
