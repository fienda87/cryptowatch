import 'package:flutter/material.dart';

import 'app.dart';
import 'layar/detail.dart';
import 'layar/login.dart';
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
      //nanti ganti jadi '/login' kalau firebase sudah masuk
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanUtama(),
        '/detail': (context) => const LayarDetail(),
        '/login': (context) => LayarMasuk(),

      },
    );
  }
}
