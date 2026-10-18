import 'package:flutter/material.dart';
import '../../theme/warna.dart';

class LayarPantauan extends StatelessWidget {
  LayarPantauan({super.key, required this.kePasar});

  var kePasar;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: WarnaApp.permukaan,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.star_border,
                  size: 48,
                  color: WarnaApp.teksRedup,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Pantauan kosong',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: WarnaApp.teksUtama,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pantau koin favoritmu di satu tempat. Tambahkan dari Pasar.',
                textAlign: TextAlign.center,
                style: TextStyle(color: WarnaApp.teksRedup),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: kePasar,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: WarnaApp.aksen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.show_chart, color: Colors.black, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Jelajahi Pasar',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
