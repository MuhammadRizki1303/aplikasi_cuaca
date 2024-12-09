import 'package:flutter/material.dart';
import 'package:aplikasi_cuaca/api/MapApi.dart';
import 'package:aplikasi_cuaca/ui/Weather.dart';
import 'package:aplikasi_cuaca/modal/WeatherData.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherData? _weatherData;
  late List<Color> _gradientColors;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _gradientColors = [
      Colors.blue[600]!, // Biru
      Colors.white, // Putih
      const Color.fromARGB(255, 251, 140, 0), // Oranye
    ];
    _currentIndex = 0;
    _startGradientAnimation();
    getCurrentLocation();
  }

  // Fungsi untuk memulai animasi warna gradien
  void _startGradientAnimation() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _gradientColors.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 3), // Durasi transisi warna
        curve: Curves.easeInOut, // Kurva transisi
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _gradientColors[_currentIndex],
              _gradientColors[(_currentIndex + 1) % _gradientColors.length],
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _weatherData != null
            ? Weather(
                weatherData:
                    _weatherData!) // Menampilkan data cuaca jika tersedia
            : Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Layanan lokasi tidak aktif.'),
        ),
      );
      return;
    }

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
