import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami'),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang Kami',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '"Menyediakan Prakiraan Cuaca Akurat untuk Hidup Lebih Terencana"',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            // Content Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    title: 'Siapa Kami?',
                    icon: Icons.info_outline_rounded,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Kami adalah tim pengembang aplikasi yang berfokus pada penyediaan informasi cuaca terkini. Dengan teknologi terkini, kami membantu pengguna untuk selalu siap menghadapi kondisi cuaca.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildSectionHeader(
                    title: 'Keunggulan Kami',
                    icon: Icons.star_rounded,
                  ),
                  SizedBox(height: 10.0),
                  _buildFeature(
                    icon: Icons.sunny,
                    title: 'Data Akurat',
                    description:
                        'Informasi cuaca didasarkan pada data terpercaya dan pembaruan real-time.',
                  ),
                  _buildFeature(
                    icon: Icons.cloud_outlined,
                    title: 'Antarmuka Mudah',
                    description:
                        'Tampilan yang sederhana namun elegan memudahkan pengguna dalam mengakses informasi.',
                  ),
                  _buildFeature(
                    icon: Icons.storm,
                    title: 'Notifikasi Penting',
                    description:
                        'Dapatkan notifikasi langsung untuk cuaca buruk atau kondisi ekstrem.',
                  ),
                  _buildFeature(
                    icon: Icons.umbrella,
                    title: 'Prakiraan Hujan',
                    description:
                        'Kami memberikan informasi mengenai kemungkinan hujan dengan detail tingkat tinggi.',
                  ),
                  _buildFeature(
                    icon: Icons.ac_unit,
                    title: 'Prakiraan Suhu',
                    description:
                        'Informasi lengkap suhu harian dan mingguan untuk persiapan lebih baik.',
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Aksi tombol
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 15.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Text(
                        'Pelajari Lebih Lanjut',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            // Footer Section
            Container(
              width: double.infinity,
              color: Colors.blue.shade50,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  '© 2024 Aplikasi Cuaca. Semua Hak Dilindungi.',
                  style: TextStyle(color: Colors.blue.shade800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 28.0,
            color: Colors.blue.shade800,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required IconData icon}) {
    return Row(
      children: [
        Icon(icon, size: 28.0, color: Colors.blue.shade800),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
      ],
    );
  }
}
