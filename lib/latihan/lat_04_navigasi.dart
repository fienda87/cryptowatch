import 'package:flutter/material.dart';

import '../theme/warna.dart';

// LATIHAN 4 — Navigasi & arguments
//
// SOAL:
// - Halaman ini isinya 3 tombol: Bitcoin, Ethereum, Solana
// - Tap tombol -> Navigator.pushNamed(context, '/latihan4/detail', arguments: nama)
// - Di kelas DetailLatihan (bawah file ini), ambil argumennya:
//   var nama = ModalRoute.of(context)!.settings.arguments as String;
// - Tampilkan nama itu besar di tengah + tombol 'Kembali' (Navigator.pop)
//
// INGAT: route '/latihan4/detail' sudah didaftarin di main.dart
class Latihan4 extends StatelessWidget {
  const Latihan4({super.key});

  @override
  Widget build(BuildContext context) {
    // tulis di sini
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'latihan 4 belum diisi',
        style: TextStyle(color: WarnaApp.teksRedup),
      ),
    );
  }
}

// halaman tujuan, isi sendiri juga
class DetailLatihan extends StatelessWidget {
  const DetailLatihan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Center(
        child: Text(
          'detail belum diisi',
          style: TextStyle(color: WarnaApp.teksRedup),
        ),
      ),
    );
  }
}
