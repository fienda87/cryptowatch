import 'package:flutter/material.dart';

import '../theme/warna.dart';

// LATIHAN 2 — ListView & daftar
//
// SOAL:
// - Bikin var data = ['Bitcoin', 'Ethereum', 'Solana', 'BNB']
// - Tampilkan pakai ListView.builder (bukan ListView children)
// - Tiap item: nomor urut, nama, sama ikon panah di kanan
// - Item ada jarak 8 antar item (pakai margin, bukan SizedBox di list)
//
// BONUS (kalau sudah selesai):
// - Pindahin satu item jadi widget sendiri, namanya BarisLatihan
// - Kasih parameter, jadi BarisLatihan(nama: 'Bitcoin', nomor: 1)
class Latihan2 extends StatelessWidget {
  const Latihan2({super.key});

  @override
  Widget build(BuildContext context) {
    // tulis di sini
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'latihan 2 belum diisi',
        style: TextStyle(color: WarnaApp.teksRedup),
      ),
    );
  }
}
