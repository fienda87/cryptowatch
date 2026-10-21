import 'package:flutter/material.dart';

import '../theme/warna.dart';

// menu latihan, buat belajar doang. hapus aja kalau sudah dikumpul
class LayarLatihan extends StatelessWidget {
  const LayarLatihan({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _baris(context, '1. Row, Column, padding, Expanded', '/latihan1'),
        _baris(context, '2. ListView & daftar', '/latihan2'),
        _baris(context, '3. State & pencarian', '/latihan3'),
        _baris(context, '4. Navigasi & arguments', '/latihan4'),
        _baris(context, '5. Responsif (landscape)', '/latihan5'),
        SizedBox(height: 12),
        Text(
          'Kerjain satu per satu. Soalnya ada di komentar paling atas tiap file.',
          style: TextStyle(color: WarnaApp.teksRedup, fontSize: 12),
        ),
      ],
    );
  }

  Widget _baris(BuildContext context, String judul, String rute) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, rute);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: WarnaApp.permukaan,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: WarnaApp.pemisah, width: 0.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(judul, style: TextStyle(color: WarnaApp.teksUtama)),
            ),
            Icon(Icons.chevron_right, size: 20, color: WarnaApp.teksRedup),
          ],
        ),
      ),
    );
  }
}
