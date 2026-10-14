import 'package:flutter/material.dart';
import '../../theme/warna.dart';

// placeholder baris koin, kotak abu nanti diganti data api
class BarisKoinKosong extends StatelessWidget {
  const BarisKoinKosong({super.key});

  @override
  Widget build(BuildContext context) {
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
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 90, height: 12, color: WarnaApp.permukaanTinggi),
                  SizedBox(height: 6),
                  Container(width: 45, height: 10, color: WarnaApp.permukaanTinggi),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(width: 70, height: 12, color: WarnaApp.permukaanTinggi),
                  SizedBox(height: 6),
                  Container(width: 45, height: 10, color: WarnaApp.permukaanTinggi),
                ],
              ),
              SizedBox(width: 8),
              Icon(Icons.star_border, color: WarnaApp.teksRedup, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
