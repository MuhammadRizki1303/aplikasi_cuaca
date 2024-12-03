import 'package:flutter/material.dart';
import 'package:aplikasi_cuaca/api/MapApi.dart';
import 'package:aplikasi_cuaca/ui/Weather.dart';
import 'package:aplikasi_cuaca/modal/WeatherData.dart';
import 'package:geolocator/geolocator.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherData? _weatherData;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _weatherData != null
          ? Weather(weatherData: _weatherData!)
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
    );
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Layanan lokasi tidak aktif.'),
        ),
      );
      return;
    }

    // Cek izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Izin lokasi ditolak.'),
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Izin lokasi ditolak secara permanen.'),
        ),
      );
      return;
    }

    // Ambil lokasi saat ini
    Position location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    loadWeather(lat: location.latitude, lon: location.longitude);
  }

  Future<void> loadWeather({required double lat, required double lon}) async {
    try {
      MapApi mapApi = MapApi.getInstance();
      final data = await mapApi.getWeather(lat: lat, lon: lon);

      setState(() {
        _weatherData = data;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memuat data cuaca: $error'),
        ),
      );
    }
  }
}
