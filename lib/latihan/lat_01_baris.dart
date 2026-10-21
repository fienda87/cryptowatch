import 'package:flutter/material.dart';
import 'package:cryptowatch/layar/widgets/baris_koin.dart';
import '../model/koin.dart';
import '../theme/warna.dart';

// LATIHAN 1 — Row, Column, padding, Expanded
//
// SOAL:
// - Bikin 1 kartu koin di tengah layar
// - Kiri: lingkaran 40px isi huruf awal simbol (contoh 'B' buat BTC)
// - Sebelah kanan lingkaran: nama (tebal) di atas, simbol di bawah
// - Ujung kanan kartu: harga di atas, persen di bawah (rata kanan)
// - Kartu selebar layar, padding 12, sudut radius 12, jarak avatar ke teks 12
// - Boleh: Row, Column, Container, Padding, Expanded, SizedBox, Text
// - width cuma boleh dipakai di lingkarannya
//
// JEBAKAN:
// - Row di dalam Row tanpa Expanded -> overflow
// - harga panjang (Rp 1.234.567.890) bikin nama kepotong
//
// CEK: kecilin lebar jendela / pakai HP sempit, kalau ada garis kuning hitam
// berarti masih overflow
class Latihan1 extends StatelessWidget {
  const Latihan1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,     // kartu di tengah layar
        crossAxisAlignment: CrossAxisAlignment.stretch,  // kartu selebar layar
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: WarnaApp.permukaan,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: WarnaApp.pemisah, width: 0.5),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: WarnaApp.permukaanTinggi,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'B',
                      style: TextStyle(
                        color: WarnaApp.teksUtama,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bitcoin',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: WarnaApp.teksUtama,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'BTC',
                        style: TextStyle(color: WarnaApp.teksRedup, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rp 1.234.567.890',
                      style: TextStyle(
                        color: WarnaApp.teksUtama,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '+1,25%',
                      style: TextStyle(color: WarnaApp.untung, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}