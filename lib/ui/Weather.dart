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
      backgroundColor: Colors.blue.shade800,
      appBar: AppBar(
        title: const Text('Cuaca Saat Ini'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildHeaderSection(),
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.35,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
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
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
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
            weatherData.name,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now()),
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weatherData.temp.toStringAsFixed(0)}°C',
                    style: const TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    weatherData.main,
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Image.network(
                'http://openweathermap.org/img/wn/${weatherData.icon}.png',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Text(
            '"Stay positive and enjoy the weather!"',
            style: const TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hourly Forecast',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue.shade800, size: 30.0),
          const SizedBox(height: 5.0),
          Text(
            time,
            style: const TextStyle(fontSize: 14.0),
          ),
          const SizedBox(height: 5.0),
          Text(
            temp,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today’s Details',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailItem('Humidity', '${weatherData.humidity}%'),
            _buildDetailItem('Wind', '${weatherData.windSpeed} km/h'),
            _buildDetailItem('Pressure', '${weatherData.pressure} hPa'),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}