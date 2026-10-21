import 'package:flutter/material.dart';

import '../theme/warna.dart';

// LATIHAN 5 — Responsif (landscape)
//
// SOAL:
// - Bungkus isi layar pakai LayoutBuilder
// - Di dalamnya bikin 3 kartu contoh (Container tinggi 80, warna permukaan)
// - Kalau batas.maxWidth > 600 -> 3 kartu sejajar (Row)
//   kalau nggak -> numpuk ke bawah (Column)
// - Kartu di dalam Row wajib pakai Expanded biar nggak overflow
//
// BONUS:
// - Tampilkan MediaQuery.of(context).orientation sebagai teks kecil
// - Coba putar HP ke landscape, pastikan nggak ada overflow
class Latihan5 extends StatelessWidget {
  const Latihan5({super.key});

  @override
  Widget build(BuildContext context) {
    // tulis di sini
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'latihan 5 belum diisi',
        style: TextStyle(color: WarnaApp.teksRedup),
      ),
    );
  }
}
