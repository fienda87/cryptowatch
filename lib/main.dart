import 'package:flutter/material.dart';
import 'app.dart';
import 'theme/tema.dart';

void main() {
  runApp(MyApp());
}

// app utama
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TemaApp.gelap,
      // DEV: login disimpan lib/layar/login.dart, dibuka lagi nanti
      home: const HalamanUtama(),
    );
  }
}
