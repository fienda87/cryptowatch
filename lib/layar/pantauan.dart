import 'package:flutter/material.dart';
import '../../theme/warna.dart';

class LayarPantauan extends StatelessWidget {
  const LayarPantauan({super.key, required this.kePasar});

  final void Function() kePasar;

  @override
  Widget build(BuildContext context) {
    // pantauan masih kosong, nanti diisi dari pasar
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: WarnaApp.permukaan,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star_border, size: 48, color: WarnaApp.teksRedup),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Pantauan kosong',
            style: TextStyle(
              color: WarnaApp.teksUtama,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pantau koin favoritmu di satu tempat. Tambahkan dari Pasar.',
            style: TextStyle(color: WarnaApp.teksRedup),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: kePasar,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: WarnaApp.aksen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.show_chart, color: Colors.black, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Jelajahi Pasar',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
