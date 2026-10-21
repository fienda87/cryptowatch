import 'package:flutter/material.dart';
import '../model/koin.dart';
import '../../theme/warna.dart';

// detail koin, kotak2 sekelton dulu
class LayarDetail extends StatefulWidget {
  const LayarDetail({super.key});

  @override
  State<LayarDetail> createState() => _LayarDetailState();
}

class _LayarDetailState extends State<LayarDetail> {
  Widget kotakStat(String judul, String nilai) {
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
            Text(
              nilai,
              style: TextStyle(
                color: WarnaApp.teksUtama,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var koin = ModalRoute.of(context)!.settings.arguments as Koin;
    var naik = koin.perubahan24j >= 0;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          koin.nama,
          style: TextStyle(
            color: WarnaApp.teksUtama,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: versiFavorit,
            builder: (context, nilai, anak) {
              var suka = disukai(koin);
              return IconButton(
                onPressed: () {
                  ubahFavorit(koin);
                },
                icon: Icon(
                  suka ? Icons.star : Icons.star_border,
                  color: suka ? WarnaApp.aksen : WarnaApp.teksUtama,
                ),
              );
            },
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
                  child: Center(
                    child: Text(
                      koin.simbol[0],
                      style: TextStyle(
                        color: WarnaApp.teksUtama,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            koin.simbol,
                            style: TextStyle(
                              color: WarnaApp.teksUtama,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: WarnaApp.permukaanTinggi,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'USD',
                              style: TextStyle(
                                color: WarnaApp.teksRedup,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Harga pasar',
                        style: TextStyle(color: WarnaApp.teksRedup, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row( // harga
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatHarga(koin.harga),
                  style: TextStyle(
                    color: WarnaApp.teksUtama,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: WarnaApp.permukaan,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${naik ? '+' : ''}${koin.perubahan24j.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: naik ? WarnaApp.untung : WarnaApp.rugi,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row( // statistik
              children: [
                kotakStat('Kap Pasar', '\$${formatRingkas(koin.kapPasar)}'),
                const SizedBox(width: 8),
                kotakStat('Volume 24j', '\$${formatRingkas(koin.volume24j)}'),
                const SizedBox(width: 8),
                kotakStat('Tertinggi', formatHarga(koin.tertinggi)),
              ],
            ),
            const SizedBox(height: 16),
            Row( // grafik
              children: [
                const Text(
                  'Grafik harga',
                  style: TextStyle(color: WarnaApp.teksUtama, fontSize: 16, fontWeight: FontWeight.w700),
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
                      fontWeight: FontWeight.w700,
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
              style: TextStyle(color: WarnaApp.teksUtama, fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              koin.deskripsi,
              style: TextStyle(color: WarnaApp.teksRedup, fontSize: 13, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
