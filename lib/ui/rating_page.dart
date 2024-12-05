import 'package:flutter/material.dart';

class RatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penilaian Aplikasi'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Beri Penilaian',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Kami sangat menghargai masukan dan penilaian Anda untuk membantu kami meningkatkan aplikasi ini.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logika untuk memberikan penilaian aplikasi
                },
                child: Text('Beri Penilaian'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
