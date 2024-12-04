import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aplikasi_cuaca/modal/WeatherData.dart';

class Weather extends StatelessWidget {
  final WeatherData weatherData;

  const Weather({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format untuk menampilkan tanggal
    Widget dateSection = Container(
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            weatherData.name, // Nama kota
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            DateFormat('EEEE, d MMMM yyyy', 'id_ID')
                .format(DateTime.now()), // Menggunakan format tanggal Indonesia
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    // Menampilkan suhu dengan besar dan ikon cuaca
    Widget tempSection = Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            '${weatherData.temp.toStringAsFixed(0)}°C', // Suhu saat ini
            style: TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.0),
          Image.network(
            'http://openweathermap.org/img/wn/${weatherData.icon}.png',
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10.0),
          Text(
            weatherData.main, // Menampilkan jenis cuaca (Rain, Cloudy, etc.)
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    // Menampilkan suhu yang dirasakan (Feels Like)
    Widget feelsLikeSection = Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        'Terasa seperti ${weatherData.feelsLike.toStringAsFixed(0)}°C', // Mengubah ke Bahasa Indonesia
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    );

    // Bagian cuaca per jam (Timeline cuaca)
    Widget hourlyForecastSection = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: SingleChildScrollView(
        // Membuat cuaca per jam bisa digulir
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildHourlyForecast('01:00', '28°C', 'Hujan'),
            _buildHourlyForecast('02:00', '27°C', 'Berawan'),
            _buildHourlyForecast('03:00', '26°C', 'Cerah'),
            _buildHourlyForecast('04:00', '25°C', 'Cerah'),
            _buildHourlyForecast('05:00', '24°C', 'Hujan'),
          ],
        ),
      ),
    );

    // Bagian proyeksi cuaca 7 hari menggunakan Card
    Widget weeklyForecastSection = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'Cuaca Minggu Ini',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.0),
          _buildDailyForecastCard('Kamis', '28°C', 'Berawan'),
          _buildDailyForecastCard('Jumat', '27°C', 'Hujan'),
          _buildDailyForecastCard('Sabtu', '30°C', 'Cerah'),
          _buildDailyForecastCard('Minggu', '22°C', 'Berawan'),
        ],
      ),
    );

    return SingleChildScrollView(
      // Membungkus seluruh widget agar bisa digulir
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          // Menggunakan Gradien untuk background
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange.shade400, // Pagi (Oranye)
              Colors.blue.shade600, // Siang (Biru)
              Colors.blue.shade900, // Sore (Biru gelap)
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            dateSection,
            tempSection,
            feelsLikeSection,
            hourlyForecastSection,
            weeklyForecastSection,
          ],
        ),
      ),
    );
  }

  // Widget untuk forecast per jam
  Widget _buildHourlyForecast(String time, String temp, String weather) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            time,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            temp,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            weather,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk forecast per hari menggunakan Card
  Widget _buildDailyForecastCard(String day, String temp, String weather) {
    return Card(
      color: Colors.blue[800],
      margin: EdgeInsets.symmetric(vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              day,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  temp,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.wb_sunny,
                  color: Colors.white,
                  size: 24.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
