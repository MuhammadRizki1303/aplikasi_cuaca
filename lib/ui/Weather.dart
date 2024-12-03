import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aplikasi_cuaca/modal/WeatherData.dart';

class Weather extends StatelessWidget {
  final WeatherData weatherData;

  const Weather({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget dateSection = Container(
      child: Text(
        DateFormat('MMMM d, H:mm').format(DateTime.now()),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24.0,
        ),
      ),
    );

    Widget tempSection = Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            weatherData.temp.toStringAsFixed(0),
            style: const TextStyle(fontSize: 80.0, color: Colors.white),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12.0, left: 6.0),
            child: Text(
              '\u2103',
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),
          const Spacer(),
          Image.network(
            'http://openweathermap.org/img/wn/${weatherData.icon}.png',
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );

    Widget descriptionSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            weatherData.name,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            weatherData.main,
            style: const TextStyle(
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dateSection,
          const SizedBox(height: 20.0),
          tempSection,
          const SizedBox(height: 20.0),
          descriptionSection,
        ],
      ),
    );
  }
}
