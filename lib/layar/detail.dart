import 'package:flutter/material.dart';
import '../../theme/warna.dart';

// detail koin, kotak2 dulu
class LayarDetail extends StatefulWidget {
  const LayarDetail({super.key});

  @override
  State<LayarDetail> createState() => _LayarDetailState();
}

class _LayarDetailState extends State<LayarDetail> {
  Widget kotak(double lebar, double tinggi) {
    return Container(width: lebar, height: tinggi, color: WarnaApp.permukaanTinggi);
  }

  Widget kotakStatKosong(String judul) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: WarnaApp.permukaan,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: WarnaApp.pemisah, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(judul, style: const TextStyle(color: WarnaApp.teksRedup, fontSize: 12)),
            const SizedBox(height: 6),
            kotak(70, 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: kotak(100, 16),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row( // kepala
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: WarnaApp.permukaanTinggi,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          kotak(120, 18),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: WarnaApp.permukaanTinggi,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: kotak(24, 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      kotak(50, 12),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row( // harga
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                kotak(150, 24),
                const SizedBox(width: 8),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: WarnaApp.permukaan,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: kotak(50, 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row( // statistik
              children: [
                kotakStatKosong('Kap Pasar'),
                const SizedBox(width: 8),
                kotakStatKosong('Volume 24j'),
                const SizedBox(width: 8),
                kotakStatKosong('Tertinggi'),
              ],
            ),
            const SizedBox(height: 16),
            Row( // grafik
              children: [
                const Text(
                  'Grafik harga',
                  style: TextStyle(color: WarnaApp.teksUtama, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: WarnaApp.permukaanTinggi,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: WarnaApp.pemisah),
                  ),
                  child: const Text(
                    '24J',
                    style: TextStyle(
                      color: WarnaApp.teksUtama,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container( // grafiknya nanti
              height: 220,
              decoration: BoxDecoration(
                color: WarnaApp.permukaan,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: WarnaApp.pemisah, width: 0.5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.show_chart, color: WarnaApp.teksRedup, size: 40),
                  SizedBox(width: 8),
                  Text('grafik nyusul', style: TextStyle(color: WarnaApp.teksRedup)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi',
              style: TextStyle(color: WarnaApp.teksUtama, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            kotak(double.infinity, 12),
            const SizedBox(height: 6),
            kotak(double.infinity, 12),
            const SizedBox(height: 6),
            kotak(200, 12),
          ],
        ),
      ),
    );
  }
}
