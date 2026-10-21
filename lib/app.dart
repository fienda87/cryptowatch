import 'package:flutter/material.dart';
import 'layar/pantauan.dart';
import 'layar/pasar.dart';
import 'layar/pengaturan.dart';
import 'theme/warna.dart';

// bawah manual aja
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int tab = 0;

  // tombol bawah
  Widget tombolBawah(String label, IconData ikon, int urutan) {
    var aktif = tab == urutan;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            tab = urutan;
          });
        },
        child: Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          color: WarnaApp.latar,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                ikon,
                color: aktif ? WarnaApp.aksen : WarnaApp.teksRedup,
                size: 20,
              ),
              SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: aktif ? WarnaApp.aksen : WarnaApp.teksRedup,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isi = IndexedStack(
      index: tab,
      children: [
        LayarPasar(),
        LayarPantauan(
          kePasar: () {
            setState(() {
              tab = 0;
            });
          },
        ),
        LayarPengaturan()
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tab == 0 ? 'Pasar' : (tab == 1 ? 'Pantauan' : 'Pengaturan'),
        ),
      ),
      // landscape:
      body: SafeArea(top: false, bottom: false, child: isi),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: WarnaApp.pemisah)),
          ),
          child: Row(
            children: [
              tombolBawah('Pasar', Icons.show_chart, 0),
              tombolBawah('Pantauan', Icons.star_border, 1),
              tombolBawah('Pengaturan', Icons.settings_outlined, 2),

            ],
          ),
        ),
      ),
    );
  }
}
