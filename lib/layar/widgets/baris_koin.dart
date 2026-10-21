import 'package:flutter/material.dart';
import '../../model/koin.dart';
import '../../theme/warna.dart';

// baris koin
class BarisKoin extends StatelessWidget {
  BarisKoin({super.key, required this.koin});

  final Koin koin;

  @override
  Widget build(BuildContext context) {
    var naik = koin.perubahan24j >= 0;
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WarnaApp.permukaan,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: WarnaApp.pemisah, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: WarnaApp.permukaanTinggi,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    koin.simbol[0],
                    style: TextStyle(
                      color: WarnaApp.teksUtama,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    koin.nama,
                    style: TextStyle(
                      color: WarnaApp.teksUtama,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    koin.simbol,
                    style: TextStyle(color: WarnaApp.teksRedup, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatHarga(koin.harga),
                style: TextStyle(
                  color: WarnaApp.teksUtama,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${naik ? '+' : ''}${koin.perubahan24j.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: naik ? WarnaApp.untung : WarnaApp.rugi,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
