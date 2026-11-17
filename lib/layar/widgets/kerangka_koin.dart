import 'package:flutter/material.dart';

import '../../theme/warna.dart';

// kotak loading
class KerangkaKoin extends StatelessWidget {
  const KerangkaKoin({super.key});

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
              Container(
                width: 110,
                height: 12,
                decoration: BoxDecoration(
                  color: WarnaApp.permukaanTinggi,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 56,
                height: 10,
                decoration: BoxDecoration(
                  color: WarnaApp.permukaanTinggi,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 80,
                height: 12,
                decoration: BoxDecoration(
                  color: WarnaApp.permukaanTinggi,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 48,
                height: 10,
                decoration: BoxDecoration(
                  color: WarnaApp.permukaanTinggi,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
