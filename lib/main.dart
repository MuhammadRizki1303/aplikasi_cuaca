import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:intl/intl.dart'; // Pastikan ini diimport untuk format tanggal
import 'package:intl/date_symbol_data_local.dart'; // Import ini untuk inisialisasi locale
import 'package:aplikasi_cuaca/ui/MyHomePage.dart';

void main() {
  // Inisialisasi locale untuk 'id_ID' (Indonesia)
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      title: 'Aplikasi Cuaca',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlueAccent, // Warna latar belakang
      ),
      home: MyHomePage(
          title: 'Aplikasi Cuaca Saya'), // Menuju ke halaman MyHomePage
    );
  }
}
