import 'package:flutter/material.dart';
import 'warna.dart';

// tema gelap gaya crypto_dashboard tanpa google_fonts
class TemaApp {
  static ThemeData get gelap {
    var dasar = ThemeData(brightness: Brightness.dark, useMaterial3: true);
    return dasar.copyWith(
      scaffoldBackgroundColor: WarnaApp.latar,
      colorScheme: ColorScheme.dark(
        primary: WarnaApp.aksen,
        surface: WarnaApp.permukaan,
        onSurface: WarnaApp.teksUtama,
        onSurfaceVariant: WarnaApp.teksRedup,
        outlineVariant: WarnaApp.pemisah,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: WarnaApp.latar,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: WarnaApp.teksUtama,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}
