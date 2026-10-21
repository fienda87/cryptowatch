import 'package:flutter/material.dart';

import '../theme/warna.dart';

// LATIHAN 3 — State & pencarian
//
// SOAL:
// - Bikin StatefulWidget, simpan String cari = ''
// - Ada TextField di atas, onChanged -> setState
// - Di bawahnya ListView hasil saring dari data:
//   ['Bitcoin', 'Ethereum', 'Solana', 'BNB', 'XRP']
// - Kalau hasil kosong, tampilkan teks 'nggak ketemu'
//
// BONUS:
// - Tambah 2 chip: Semua / Naik, pakai int pilih + setState
// - Latihan tambah/kurang: satu angka, tombol + dan -, jangan sampai minus
class Latihan3 extends StatefulWidget {
  const Latihan3({super.key});

  @override
  State<Latihan3> createState() => _Latihan3State();
}

class _Latihan3State extends State<Latihan3> {
  // tulis variabel di sini

  @override
  Widget build(BuildContext context) {
    // tulis di sini
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'latihan 3 belum diisi',
        style: TextStyle(color: WarnaApp.teksRedup),
      ),
    );
  }
}
