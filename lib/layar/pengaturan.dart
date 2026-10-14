import 'package:flutter/material.dart';
import '../../theme/warna.dart';

class LayarPengaturan extends StatefulWidget {
  const LayarPengaturan({super.key});

  @override
  State<LayarPengaturan> createState() => _LayarPengaturanState();
}

class _LayarPengaturanState extends State<LayarPengaturan> {
  String nama = '';
  bool ubah = false;
  var kontrolNama = TextEditingController();

  @override
  void dispose() {
    kontrolNama.dispose();
    super.dispose();
  }

  String inisial() {
    var rapi = nama.trim();
    if (rapi.isEmpty) {
      return '?';
    }
    return rapi[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // kartu profil
            Container(
              padding: const EdgeInsets.all(16),
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
                    decoration: const BoxDecoration(
                      color: WarnaApp.permukaanTinggi,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        inisial(),
                        style: const TextStyle(
                          color: WarnaApp.aksen,
                          fontSize: 24,
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
                        Text(
                          nama.isEmpty ? '-' : nama,
                          style: const TextStyle(
                            color: WarnaApp.teksUtama,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'belum masuk',
                          style: TextStyle(color: WarnaApp.teksRedup, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ubah nama
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
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: TextField(
                        controller: kontrolNama,
                        style: const TextStyle(color: WarnaApp.teksUtama),
                        decoration: const InputDecoration(
                          labelText: 'Nama',
                          labelStyle: TextStyle(color: WarnaApp.teksRedup),
                          isDense: true,
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      if (ubah) {
                        setState(() {
                          nama = kontrolNama.text.trim();
                          ubah = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Nama diperbarui')),
                        );
                      } else {
                        kontrolNama.text = nama;
                        setState(() {
                          ubah = true;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Icon(
                            ubah ? Icons.check : Icons.edit_outlined,
                            size: 22,
                            color: WarnaApp.teksUtama,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              ubah ? 'Simpan nama' : 'Ubah nama',
                              style: const TextStyle(color: WarnaApp.teksUtama),
                            ),
                          ),
                          const Icon(Icons.chevron_right, size: 20, color: WarnaApp.teksRedup),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // keluar
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
                        title: const Text('Keluar?'),
                        content: const Text('Kamu harus masuk lagi untuk membuka app.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(c);
                            },
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(c);
                            },
                            child: const Text('Keluar', style: TextStyle(color: WarnaApp.rugi)),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 22, color: WarnaApp.rugi),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text('Keluar', style: TextStyle(color: WarnaApp.rugi)),
                      ),
                      Icon(Icons.chevron_right, size: 20, color: WarnaApp.teksRedup),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Text(
                  'Xcrypto v1.0.0',
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
