import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'warna.dart';

// tema gelap
class TemaApp {
  static ThemeData get gelap {
    var dasar = ThemeData(brightness: Brightness.dark, useMaterial3: true);
    // font inter
    var fontInter = GoogleFonts.inter().fontFamily;
    return dasar.copyWith(
      textTheme: dasar.textTheme.apply(fontFamily: fontInter),
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
      // dialog disamain sama warna app, ukuran teksnya seimbang
      dialogTheme: DialogThemeData(
        backgroundColor: WarnaApp.permukaanTinggi,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        titleTextStyle: TextStyle(
          color: WarnaApp.teksUtama,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        contentTextStyle: TextStyle(
          color: WarnaApp.teksRedup,
          fontSize: 13,
          height: 1.4,
        ),
        actionsPadding: EdgeInsets.fromLTRB(8, 0, 8, 6),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: WarnaApp.aksen,
          textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
      // snackbar bawah juga ikut gelap, bukan putih
      snackBarTheme: SnackBarThemeData(
        backgroundColor: WarnaApp.permukaanTinggi,
        contentTextStyle: TextStyle(color: WarnaApp.teksUtama, fontSize: 13),
        actionTextColor: WarnaApp.aksen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
