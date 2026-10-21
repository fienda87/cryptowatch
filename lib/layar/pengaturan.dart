import 'package:flutter/material.dart';

import '../../theme/warna.dart';

class LayarPengaturan extends StatefulWidget {
  LayarPengaturan({super.key});

  @override
  State<LayarPengaturan> createState() => _LayarPengaturanState();
}

class _LayarPengaturanState extends State<LayarPengaturan> {
  String nama = '';
  bool ubah = false;
  var kontrolNama = TextEditingController();

  String inisial() {
    if (nama.trim().isEmpty) {
      return '?';
    }
    return nama.trim()[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: WarnaApp.permukaan,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: WarnaApp.pemisah, width: 0.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: WarnaApp.permukaanTinggi,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        inisial(),
                        style: TextStyle(
                          color: WarnaApp.aksen,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama.isEmpty ? '-' : nama,
                          style: TextStyle(
                            color: WarnaApp.teksUtama,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'belum masuk',
                          style: TextStyle(
                            color: WarnaApp.teksRedup,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: WarnaApp.permukaan,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: WarnaApp.pemisah, width: 0.5),
              ),
              child: Column(
                children: [
                  if (ubah)
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: TextField(
                        controller: kontrolNama,
                        style: TextStyle(color: WarnaApp.teksUtama),
                        decoration: InputDecoration(labelText: 'Nama'),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      if (ubah) {
                        setState(() {
                          nama = kontrolNama.text;
                          ubah = false;
                        });
                      } else {
                        kontrolNama.text = nama;
                        setState(() {
                          ubah = true;
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            ubah ? Icons.check : Icons.edit_outlined,
                            size: 22,
                            color: WarnaApp.teksUtama,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              ubah ? 'Simpan nama' : 'Ubah nama',
                              style: TextStyle(color: WarnaApp.teksUtama),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: WarnaApp.teksRedup,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: WarnaApp.permukaan,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: WarnaApp.pemisah, width: 0.5),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/latihan');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Icon(
                        Icons.school_outlined,
                        size: 22,
                        color: WarnaApp.teksUtama,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Latihan UI',
                          style: TextStyle(color: WarnaApp.teksUtama),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: WarnaApp.teksRedup,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: WarnaApp.permukaan,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: WarnaApp.pemisah, width: 0.5),
              ),

              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (c) {
                      return AlertDialog(
                        title: Text('Keluar?'),
                        content: Text(
                          'Kamu harus masuk lagi untuk membuka app.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(c);
                            },
                            child: Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(c);
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text(
                              'Keluar',
                              style: TextStyle(color: WarnaApp.rugi),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 22, color: WarnaApp.rugi),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Keluar',
                          style: TextStyle(color: WarnaApp.rugi),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: WarnaApp.teksRedup,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'CryptoWatch v1.0.0',
                  style: TextStyle(color: WarnaApp.teksRedup, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
