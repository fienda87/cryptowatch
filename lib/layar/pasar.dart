import 'package:flutter/material.dart';
import 'detail.dart';
import 'widgets/baris_koin.dart';
import '../../theme/warna.dart';

class LayarPasar extends StatelessWidget {
  const LayarPasar({super.key});

  void bukaDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => LayarDetail()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: TextField(
            style: TextStyle(color: WarnaApp.teksUtama, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Cari koin...',
              hintStyle: TextStyle(color: WarnaApp.teksRedup, fontSize: 14),
              prefixIcon: Icon(Icons.search, color: WarnaApp.teksRedup, size: 20),
              filled: true,
              fillColor: WarnaApp.permukaan,
              isDense: true,
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              _chip('Semua', true),
              _chip('Naik', false),
              _chip('Anjlok', false),
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Text(
            'Daftar Koin',
            style: TextStyle(
              color: WarnaApp.teksUtama,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 8),
        // list koin (api nyusul)
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              for (var i = 0; i < 6; i++)
                GestureDetector(
                  onTap: () {
                    bukaDetail(context);
                  },
                  child: BarisKoinKosong(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chip(String teks, bool pilih) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: pilih ? WarnaApp.permukaanTinggi : WarnaApp.permukaan,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: WarnaApp.pemisah),
      ),
      child: Text(
        teks,
        style: TextStyle(
          color: pilih ? WarnaApp.teksUtama : WarnaApp.teksRedup,
          fontSize: 13,
        ),
      ),
    );
  }
}
