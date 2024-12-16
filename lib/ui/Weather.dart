import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aplikasi_cuaca/modal/WeatherData.dart';
import 'about_page.dart';
import 'rating_page.dart';

class Weather extends StatefulWidget {
  final WeatherData weatherData;

  const Weather({super.key, required this.weatherData});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  int _currentIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildWeatherPage(),
      const AboutPage(),
      const RatingPage(),
    ]);

    // Menambahkan data cuaca 6 hari ke depan
    widget.weatherData.dailyForecasts = [
      DailyForecast(
          day: 'Hari Rabu',
          weather: 'Sunny',
          icon: '0xf00d',
          temperature: '25°C'),
      DailyForecast(
          day: 'Hari Kamis',
          weather: 'Cloudy',
          icon: '0xf07b',
          temperature: '22°C'),
      DailyForecast(
          day: 'Hari Jumat',
          weather: 'Rainy',
          icon: '0xf019',
          temperature: '19°C'),
      DailyForecast(
          day: 'Hari Sabtu',
          weather: 'Sunny',
          icon: '0xf00d',
          temperature: '26°C'),
      DailyForecast(
          day: 'Hari Minggu',
          weather: 'Stormy',
          icon: '0xf01e',
          temperature: '20°C'),
      DailyForecast(
          day: 'Hari Senin',
          weather: 'Cloudy',
          icon: '0xf07b',
          temperature: '21°C'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.blue.shade900,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Cuaca'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Tentang'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Rating'),
        ],
      ),
    );
  }

  Widget _buildWeatherPage() {
    return Stack(
      children: [
        _buildBackground(),
        SafeArea(child: _buildHeaderSection()),
        DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.4,
          maxChildSize: 0.8,
          builder: (context, scrollController) {
            return _buildDraggableContent(scrollController);
          },
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6DD5FA), Color(0xFF2980B9)],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.weatherData.name,
            style: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black45, blurRadius: 3.0)],
            ),
          ),
          Text(
            DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now()),
            style: const TextStyle(fontSize: 16.0, color: Colors.white70),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.weatherData.temp.toStringAsFixed(0)}°C',
                    style: const TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.weatherData.main,
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Image.network(
                'http://openweathermap.org/img/wn/${widget.weatherData.icon}.png',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableContent(ScrollController scrollController) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHourlyForecastSection(),
              const SizedBox(height: 20.0),
              _buildDetailsSection(),
              const SizedBox(height: 20.0),
              _buildDailyForecastSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHourlyForecastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Perkiraan Jam Cuaca',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildHourlyForecastCard('05:00', '23°C', Icons.wb_sunny),
              _buildHourlyForecastCard('06:00', '20°C', Icons.cloud),
              _buildHourlyForecastCard('07:00', '17°C', Icons.cloud_queue),
              _buildHourlyForecastCard('08:00', '16°C', Icons.cloud),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyForecastCard(String time, String temp, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent.shade100,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 30.0),
            const SizedBox(height: 5.0),
            Text(time, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 5.0),
            Text(temp,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      children: [
        const Text(
          'Detail Hari Ini',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailItem('Humidity', '${widget.weatherData.humidity}%'),
            _buildDetailItem('Wind', '${widget.weatherData.windSpeed} km/h'),
            _buildDetailItem('Pressure', '${widget.weatherData.pressure} hPa'),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 5.0),
        Text(value,
            style:
                const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Bagian untuk menampilkan perkiraan cuaca 6 hari ke depan
  Widget _buildDailyForecastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Perkiraan Cuaca 6 Hari Kedepan',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.weatherData.dailyForecasts.length,
          itemBuilder: (context, index) {
            final forecast = widget.weatherData.dailyForecasts[index];
            return _buildDailyForecastCard(forecast);
          },
        ),
      ],
    );
  }

  Widget _buildDailyForecastCard(DailyForecast forecast) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent.shade100,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              forecast.day,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Icon(
                  IconData(int.parse(forecast.icon),
                      fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                  size: 24.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  forecast.temperature,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
