import 'package:flutter/material.dart';
import '../../theme/warna.dart';
import '../app.dart';

// mokup halaman masuk, belum sambung auth beneran
class LayarMasuk extends StatefulWidget {
  const LayarMasuk({super.key});

  @override
  State<LayarMasuk> createState() => _LayarMasukState();
}

class _LayarMasukState extends State<LayarMasuk> {
  final _formulir = GlobalKey<FormState>();
  final _surel = TextEditingController();
  final _sandi = TextEditingController();
  bool tampilSandi = false;
  bool sibuk = false;

  @override
  void dispose() {
    _surel.dispose();
    _sandi.dispose();
    super.dispose();
  }

  // pencet masuk, validasi dulu baru pindah halaman
  void jalankan() {
    var lolos = _formulir.currentState?.validate() ?? false;
    if (!lolos) {
      return;
    }
    setState(() {
      sibuk = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) {
        return;
      }
      setState(() {
        sibuk = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => HalamanUtama()),
      );
    });
  }

  InputDecoration hias(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: WarnaApp.teksRedup),
      filled: true,
      fillColor: WarnaApp.permukaan,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: WarnaApp.pemisah),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: WarnaApp.aksen),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: WarnaApp.rugi),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: WarnaApp.rugi),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Form(
            key: _formulir,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(24),
              children: [
                const SizedBox(height: 32),
                const Icon(
                  Icons.candlestick_chart,
                  size: 56,
                  color: WarnaApp.aksen,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Xcrypto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: WarnaApp.teksUtama,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Pantau harga crypto favoritmu',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: WarnaApp.teksRedup),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _surel,
                  style: const TextStyle(color: WarnaApp.teksUtama),
                  decoration: hias('Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (nilai) {
                    if ((nilai ?? '').contains('@')) {
                      return null;
                    }
                    return 'Email tidak valid';
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _sandi,
                  style: const TextStyle(color: WarnaApp.teksUtama),
                  decoration: hias('Kata sandi').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        tampilSandi ? Icons.visibility_off : Icons.visibility,
                        color: WarnaApp.teksRedup,
                      ),
                      onPressed: () {
                        setState(() {
                          tampilSandi = !tampilSandi;
                        });
                      },
                    ),
                  ),
                  obscureText: !tampilSandi,
                  validator: (nilai) {
                    if ((nilai ?? '').length >= 6) {
                      return null;
                    }
                    return 'Min 6 karakter';
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: sibuk ? null : jalankan,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: WarnaApp.aksen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (sibuk)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                          )
                        else
                          const Text(
                            'Masuk',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: sibuk ? null : jalankan,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: WarnaApp.pemisah),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata, color: WarnaApp.teksUtama),
                        SizedBox(width: 4),
                        Text('Masuk dengan Google', style: TextStyle(color: WarnaApp.teksUtama)),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Belum punya akun? Daftar', style: TextStyle(color: WarnaApp.aksen)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
