import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/koin.dart';
import '../../theme/warna.dart';

// baris koin
class BarisKoin extends StatelessWidget {
  const BarisKoin({super.key, required this.koin});

  final Koin koin;

  @override
  Widget build(BuildContext context) {
    var naik = koin.perubahan24j >= 0;
    var warnaUbah = naik ? WarnaApp.untung : WarnaApp.rugi;
    var gaya = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(14),
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
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: WarnaApp.permukaanTinggi,
              shape: BoxShape.circle,
            ),
            // logo, gagal pakai huruf
            child: CachedNetworkImage(
              imageUrl: koin.gambar,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return SizedBox();
              },
              errorWidget: (context, url, error) {
                return Center(
                  child: Text(
                    koin.simbol[0],
                    style: TextStyle(
                      color: WarnaApp.teksUtama,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  koin.simbol,
                  style: gaya.titleMedium?.copyWith(
                    color: WarnaApp.teksUtama,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  koin.nama,
                  style: gaya.bodySmall?.copyWith(color: WarnaApp.teksRedup),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatHarga(koin.harga),
                style: gaya.titleMedium?.copyWith(
                  color: WarnaApp.teksUtama,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: warnaUbah.withAlpha(30),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${naik ? '+' : ''}${koin.perubahan24j.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: warnaUbah,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
