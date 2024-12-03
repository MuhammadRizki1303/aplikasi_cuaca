import 'package:aplikasi_cuaca/modal/WeatherData.dart';
import 'package:http/http.dart' show Client;

class MapApi {
  static const APIkey = "ad8ee6f19ecdc9f2065b5398ac06ee1e";
  static const EndPoint = "http://api.openweathermap.org/data/2.5/";

  // Singleton pattern
  static final MapApi _instance = MapApi._internal();
  factory MapApi() => _instance;

  // Private constructor
  MapApi._internal();

  final Client client = Client();

  // Mendapatkan instance tunggal
  static MapApi getInstance() => _instance;

  // Membuat URL API untuk pemanggilan data cuaca
  String _apiCall({required double lat, required double lon}) {
    return '$EndPoint/weather?lat=$lat&lon=$lon&APPID=$APIkey&units=metric';
  }

  // Fungsi untuk mengambil data cuaca dari API
  Future<WeatherData> getWeather(
      {required double lat, required double lon}) async {
    final response = await client.get(
      Uri.parse(_apiCall(lat: lat, lon: lon)),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return WeatherData.deserialize(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
