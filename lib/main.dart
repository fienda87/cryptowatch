import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'layar/daftar.dart';
import 'layar/detail.dart';
import 'layar/login.dart';
import 'model/koin.dart';
import 'theme/tema.dart';
import 'theme/warna.dart';

void main() async {
  // firebase + favorit disiapkan dulu, baru app jalan
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await muatFavorit();
  runApp(MyApp());
}

// app utama
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TemaApp.gelap,
      home: Gerbang(),
      routes: {
        '/detail': (context) => const LayarDetail(),
        '/daftar': (context) => LayarDaftar(),
      },
    );
  }
}

// nentuin layar: belum login masuk, sudah login halaman utama
class Gerbang extends StatelessWidget {
  const Gerbang({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: WarnaApp.aksen),
            ),
          );
        }
        if (snap.data == null) {
          return LayarMasuk();
        }
        return const HalamanUtama();
      },
    );
  }
}
