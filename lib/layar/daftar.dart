import 'package:flutter/material.dart';

import '../layanan/auth.dart';
import '../../theme/warna.dart';

// daftar akun
class LayarDaftar extends StatefulWidget {
  const LayarDaftar({super.key});

  @override
  State<LayarDaftar> createState() => _LayarDaftarState();
}

class _LayarDaftarState extends State<LayarDaftar> {
  var kontrolEmail = TextEditingController();
  var kontrolSandi = TextEditingController();
  var kontrolUlang = TextEditingController();
  bool memuat = false;
  String galat = '';

  void daftar() async {
    var email = kontrolEmail.text.trim();
    var sandi = kontrolSandi.text;

    if (email == '' || sandi == '') {
      setState(() {
        galat = 'Email dan sandi wajib diisi.';
      });
      return;
    }
    if (sandi != kontrolUlang.text) {
      setState(() {
        galat = 'Sandi ulangan tidak sama.';
      });
      return;
    }

    setState(() {
      memuat = true;
      galat = '';
    });

    var navigator = Navigator.of(context);

    try {
      await daftarFirebase(email, sandi);
      // langsung masuk
      navigator.pop();
    } catch (e) {
      setState(() {
        galat = pesanAuth(e);
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Daftar akun'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buat akun CryptoWatch',
                    style: TextStyle(
                      color: WarnaApp.teksUtama,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Cukup email dan sandi, minimal 6 karakter.',
                    style: TextStyle(color: WarnaApp.teksRedup, fontSize: 14),
                  ),
                  SizedBox(height: 24),
                  kolom(kontrolEmail, 'Email', false),
                  kolom(kontrolSandi, 'Sandi', true),
                  kolom(kontrolUlang, 'Ulangi sandi', true),
                  if (galat != '')
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        galat,
                        style: TextStyle(color: WarnaApp.rugi, fontSize: 13),
                      ),
                    ),
                  GestureDetector(
                    onTap: memuat ? null : daftar,
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
                          memuat ? 'Memproses...' : 'Daftar',
                          style: TextStyle(
                            color: memuat ? WarnaApp.teksRedup : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
