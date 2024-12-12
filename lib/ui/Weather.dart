import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aplikasi_cuaca/modal/WeatherData.dart';
import 'about_page.dart';
import 'rating_page.dart';

class Weather extends StatelessWidget {
  final WeatherData weatherData;

  const Weather({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuaca Saat Ini'),
        backgroundColor: Colors.blue.shade800,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
              ),
              child: const Text(
                'Menu Navigasi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Tentang Kami'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_border),
              title: const Text('Penilaian Aplikasi'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RatingPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orange.shade400, // Pagi (Oranye)
                Colors.blue.shade600, // Siang (Biru)
                Colors.blue.shade900, // Sore (Biru Gelap)
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDateSection(),
              _buildTempSection(),
              _buildFeelsLikeSection(),
              _buildHourlyForecastSection(),
              _buildWeeklyForecastSection(),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget untuk menampilkan tanggal dan lokasi
  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          weatherData.name, // Nama kota
          style: const TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now()),
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  /// Widget untuk menampilkan suhu saat ini
  Widget _buildTempSection() {
    return Column(
      children: <Widget>[
        Text(
          '${weatherData.temp.toStringAsFixed(0)}°C',
          style: const TextStyle(
            fontSize: 80.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Image.network(
          'http://openweathermap.org/img/wn/${weatherData.icon}.png',
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        Text(
          weatherData.main, // Jenis cuaca
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  /// Widget untuk menampilkan suhu yang dirasakan
  Widget _buildFeelsLikeSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        'Terasa seperti ${weatherData.feelsLike.toStringAsFixed(0)}°C',
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Widget untuk menampilkan prakiraan cuaca per jam
  Widget _buildHourlyForecastSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SingleChildScrollView(
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
  }

  /// Widget untuk menampilkan prakiraan cuaca mingguan
  Widget _buildWeeklyForecastSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          const Text(
            'Cuaca Minggu Ini',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 3,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildDailyForecastCard(
                ['Kamis', 'Jumat', 'Sabtu', 'Minggu'][index],
                '${28 + index}°C',
                ['Berawan', 'Hujan', 'Cerah', 'Berawan'][index],
              );
            },
          ),
        ],
      ),
    );
  }

  /// Widget untuk prakiraan per jam
  Widget _buildHourlyForecast(String time, String temp, String weather) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            time,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            temp,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            weather,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  /// Widget untuk kartu prakiraan harian
  Widget _buildDailyForecastCard(String day, String temp, String weather) {
    return Card(
      color: Colors.blue[800],
      margin: EdgeInsets.zero,
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
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  temp,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10.0),
                const Icon(
                  Icons.wb_sunny,
                  color: Colors.yellow,
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
