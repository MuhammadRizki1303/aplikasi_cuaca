import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final TextEditingController _controller = TextEditingController();
  String _weatherInfo = '';

  void _searchWeather() {
    setState(() {
      _weatherInfo = 'Cuaca di ${_controller.text}: Cerah, 30°C'; // Contoh data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TENTANG APLIKASI CUACA',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Aplikasi ini memberikan informasi cuaca terkini dan prakiraan cuaca secara akurat. Dikembangkan dengan Flutter untuk memberikan pengalaman terbaik kepada pengguna.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'CARI DAERAH',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Masukkan nama daerah',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _searchWeather,
              child: Text('Cuaca Saat ini'),
            ),
            SizedBox(height: 20.0),
            Text(
              _weatherInfo,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}