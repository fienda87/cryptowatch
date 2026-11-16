import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/koin.dart';
import '../../theme/warna.dart';

// grafik garis harga, dipakai di layar detail
class GrafikHarga extends StatelessWidget {
  const GrafikHarga({
    super.key,
    required this.titik,
    required this.hari,
    this.naik = true,
  });

  final List<Titik> titik;
  final int hari;
  final bool naik;

  @override
  Widget build(BuildContext context) {
    if (titik.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada data',
          style: TextStyle(color: WarnaApp.teksRedup),
        ),
      );
    }

    var spot = <FlSpot>[];
    for (var i = 0; i < titik.length; i++) {
      spot.add(FlSpot(i.toDouble(), titik[i].harga));
    }

    // batas atas bawah biar grafiknya pas
    var bawah = titik[0].harga;
    var atas = titik[0].harga;
    for (var t in titik) {
      if (t.harga < bawah) {
        bawah = t.harga;
      }
      if (t.harga > atas) {
        atas = t.harga;
      }
    }
    if (atas == bawah) {
      atas = bawah + 1;
    }

    var jarak = (atas - bawah) / 3;
    var langkahBawah = (titik.length - 1) / 3;
    if (langkahBawah < 1) {
      langkahBawah = 1;
    }

    var warna = naik ? WarnaApp.untung : WarnaApp.rugi;

    return LineChart(
      LineChartData(
        minY: bawah,
        maxY: atas,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: jarak,
          getDrawingHorizontalLine: (nilai) {
            return FlLine(color: WarnaApp.pemisah, strokeWidth: 0.5);
          },
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 58,
              interval: jarak,
              getTitlesWidget: (nilai, info) {
                return Text(
                  formatRingkas(nilai),
                  style: TextStyle(color: WarnaApp.teksRedup, fontSize: 9),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              interval: langkahBawah,
              getTitlesWidget: (nilai, info) {
                var i = nilai.toInt();
                if (i < 0 || i >= titik.length) {
                  return SizedBox();
                }
                var waktu = titik[i].waktu;
                var teks = hari <= 1
                    ? DateFormat('HH:mm').format(waktu)
                    : DateFormat('d/M').format(waktu);
                return Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    teks,
                    style: TextStyle(color: WarnaApp.teksRedup, fontSize: 9),
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spot,
            color: warna,
            barWidth: 2,
            isCurved: true,
            curveSmoothness: 0.2,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: true, color: warna.withAlpha(30)),
          ),
        ],
      ),
    );
  }
}
