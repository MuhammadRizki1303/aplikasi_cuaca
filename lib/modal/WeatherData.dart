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
  List<DailyForecast> dailyForecasts;

  WeatherData({
    required this.name,
    required this.temp,
    required this.icon,
    required this.main,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.dailyForecasts,
  });

  // Fungsi deserialize untuk WeatherData
  factory WeatherData.deserialize(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);

    // Mendapatkan data cuaca harian (daily)
    List<DailyForecast> dailyForecasts = [];
    if (json['daily'] != null) {
      dailyForecasts = (json['daily'] as List)
          .map((dailyJson) => DailyForecast.fromJson(dailyJson))
          .toList();
    }

    return WeatherData(
      name: json['name'] ?? '',
      temp: (json['main']['temp'] ?? 0).toDouble(),
      icon: json['weather'][0]['icon'] ?? '',
      main: json['weather'][0]['main'] ?? '',
      feelsLike: (json['main']['feels_like'] ?? 0).toDouble(),
      humidity: (json['main']['humidity'] ?? 0).toDouble(),
      windSpeed: (json['wind']['speed'] ?? 0).toDouble(),
      pressure: (json['main']['pressure'] ?? 0).toDouble(),
      dailyForecasts: dailyForecasts,
    );
  }
}

class DailyForecast {
  String day;
  String weather;
  String icon;
  String temperature;

  DailyForecast({
    required this.day,
    required this.weather,
    required this.icon,
    required this.temperature,
  });

  // Fungsi deserialize untuk DailyForecast
  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    // Menggunakan waktu Unix untuk mendapatkan nama hari
    DateTime date = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    String day = _getDayName(date);

    return DailyForecast(
      day: day,
      weather: json['weather'][0]['main'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      temperature: '${(json['temp']['day'] ?? 0).toDouble()}°C',
    );
  }

  // Fungsi untuk mengonversi Unix timestamp ke nama hari
  static String _getDayName(DateTime date) {
    final daysOfWeek = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu'
    ];
    return daysOfWeek[date.weekday];
  }
}

class WeatherDescription {
  final String main;

  WeatherDescription({required this.main});

  factory WeatherDescription.fromJson(Map<String, dynamic> json) {
    return WeatherDescription(main: json['main']);
  }
}
