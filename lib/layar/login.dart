import 'package:flutter/material.dart';

import '../layanan/auth.dart';
import '../../theme/warna.dart';

// login email
class LayarMasuk extends StatefulWidget {
  LayarMasuk({super.key});

  @override
  State<LayarMasuk> createState() => _LayarMasukState();
}

class _LayarMasukState extends State<LayarMasuk> {
  var kontrolEmail = TextEditingController();
  var kontrolSandi = TextEditingController();
  bool memuat = false;
  String galat = '';

  void masuk() async {
    if (kontrolEmail.text.trim() == '' || kontrolSandi.text == '') {
      setState(() {
        galat = 'Email dan sandi wajib diisi.';
      });
      return;
    }

    setState(() {
      memuat = true;
      galat = '';
    });

    try {
      await masukFirebase(kontrolEmail.text.trim(), kontrolSandi.text);
      // sukses, gerbang yang pindah
    } catch (e) {
      setState(() {
        galat = pesanAuth(e);
        memuat = false;
      });
    }
  }

  // login google
  void masukDenganGoogle() async {
    setState(() {
      memuat = true;
      galat = '';
    });
    try {
      var hasil = await masukGoogle();
      if (hasil == null) {
        // user menutup pilihan akun
        setState(() {
          memuat = false;
        });
      }
    } catch (e) {
      setState(() {
        galat = 'Google gagal. Cek sidik jari SHA-1 di Firebase.';
        memuat = false;
      });
    }
  }

  Widget kolom(TextEditingController kontrol, String label, bool rahasia) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: kontrol,
        obscureText: rahasia,
        style: TextStyle(color: WarnaApp.teksUtama),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: WarnaApp.teksRedup),
          filled: true,
          fillColor: WarnaApp.permukaan,
          contentPadding: EdgeInsets.all(14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
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
                  SizedBox(height: 32),
                  kolom(kontrolEmail, 'Email', false),
                  kolom(kontrolSandi, 'Sandi', true),
                  if (galat != '')
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        galat,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: WarnaApp.rugi, fontSize: 13),
                      ),
                    ),
                  GestureDetector(
                    onTap: memuat ? null : masuk,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: memuat
                            ? WarnaApp.permukaanTinggi
                            : WarnaApp.aksen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          memuat ? 'Memproses...' : 'Masuk',
                          style: TextStyle(
                            color: memuat ? WarnaApp.teksRedup : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Container(height: 1, color: WarnaApp.pemisah),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'atau',
                          style: TextStyle(
                            color: WarnaApp.teksRedup,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(height: 1, color: WarnaApp.pemisah),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  GestureDetector(
                    onTap: memuat ? null : masukDenganGoogle,
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
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/daftar');
                    },
                    child: Text(
                      'Belum punya akun? Daftar',
                      style: TextStyle(
                        color: WarnaApp.aksen,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
