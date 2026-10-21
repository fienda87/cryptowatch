import 'package:flutter/material.dart';
import '../../theme/warna.dart';

// login pakai google, belum sambung firebase
class LayarMasuk extends StatelessWidget {
  LayarMasuk({super.key});

  void masuk(BuildContext context) {
    // firebase nyusul
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // badge logo
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: WarnaApp.permukaan,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: WarnaApp.pemisah),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/app_icon.png',
                      width: 44,
                      height: 44,
                    ),
                  ),
                ),
                SizedBox(height: 28),
                // satu Text.rich biar basenya rata
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: WarnaApp.teksUtama,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(text: 'Masuk ke '),
                      TextSpan(
                        text: 'CryptoWatch',
                        style: TextStyle(color: WarnaApp.aksen),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Pantau harga crypto favoritmu',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: WarnaApp.teksRedup, fontSize: 15),
                ),
                SizedBox(height: 40),
                // tombol putih gaya google
                GestureDetector(
                  onTap: () {
                    masuk(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'G',
                          style: TextStyle(
                            color: Color(0xFF4285F4),
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Lanjutkan dengan Google',
                          style: TextStyle(
                            color: Color(0xFF1F1F1F),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
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
      ),
    );
  }
}
