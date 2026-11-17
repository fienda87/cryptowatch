// model koin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Koin {
  String id;
  String gambar;
  String nama;
  String simbol;
  double harga;
  double perubahan24j;
  double kapPasar;
  double volume24j;
  double tertinggi;
  double terendah;
  int peringkat;

  Koin({
    required this.id,
    required this.gambar,
    required this.nama,
    required this.simbol,
    required this.harga,
    required this.perubahan24j,
    required this.kapPasar,
    required this.volume24j,
    required this.tertinggi,
    required this.terendah,
    required this.peringkat,
  });
}

// titik grafik
class Titik {
  Titik(this.waktu, this.harga);

  DateTime waktu;
  double harga;
}

// daftar koin dari api
List<Koin> daftarKoin = [];

// json jadi koin
Koin koinDariJson(Map data) {
  var simbol = (data['symbol'] ?? '').toString().toUpperCase();
  return Koin(
    id: (data['id'] ?? '').toString(),
    gambar: (data['image'] ?? '').toString(),
    nama: (data['name'] ?? '-').toString(),
    simbol: simbol,
    harga: (data['current_price'] ?? 0).toDouble(),
    perubahan24j: (data['price_change_percentage_24h'] ?? 0).toDouble(),
    kapPasar: (data['market_cap'] ?? 0).toDouble(),
    volume24j: (data['total_volume'] ?? 0).toDouble(),
    tertinggi: (data['high_24h'] ?? 0).toDouble(),
    terendah: (data['low_24h'] ?? 0).toDouble(),
    peringkat: (data['market_cap_rank'] ?? 0).toInt(),
  );
}

// favorit
Set<String> favorit = {};
var versiFavorit = ValueNotifier(0);

Future<void> muatFavorit() async {
  var toko = await SharedPreferences.getInstance();
  favorit = (toko.getStringList('favorit') ?? []).toSet();
}

Future<void> simpanFavorit() async {
  var toko = await SharedPreferences.getInstance();
  await toko.setStringList('favorit', favorit.toList());
}

bool disukai(Koin koin) {
  return favorit.contains(koin.simbol);
}

void ubahFavorit(Koin koin) {
  if (favorit.contains(koin.simbol)) {
    favorit.remove(koin.simbol);
  } else {
    favorit.add(koin.simbol);
  }
  versiFavorit.value = versiFavorit.value + 1;
  simpanFavorit();
  simpanAwan();
}

// data per akun
DocumentReference? dokumenSaya() {
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return null;
  }
  return FirebaseFirestore.instance.collection('users').doc(user.uid);
}

// favorit dari akun
Future<void> muatAwan() async {
  var dok = dokumenSaya();
  if (dok == null) {
    return;
  }

  var isi = await dok.get();
  if (!isi.exists) {
    // akun baru, simpan favorit lokal
    await dok.set({
      'email': FirebaseAuth.instance.currentUser?.email ?? '',
      'nama': '',
      'favorit': favorit.toList(),
    });
    return;
  }

  var data = isi.data() as Map;
  favorit = (data['favorit'] as List? ?? []).map((e) => e.toString()).toSet();
  simpanFavorit();
  versiFavorit.value = versiFavorit.value + 1;
}

Future<void> simpanAwan() async {
  var dok = dokumenSaya();
  if (dok == null) {
    return;
  }
  await dok.set({'favorit': favorit.toList()}, SetOptions(merge: true));
}

Future<String> ambilNamaAwan() async {
  var dok = dokumenSaya();
  if (dok == null) {
    return '';
  }
  var isi = await dok.get();
  if (!isi.exists) {
    return '';
  }
  var data = isi.data() as Map;
  return (data['nama'] ?? '').toString();
}

Future<void> simpanNamaAwan(String nama) async {
  var dok = dokumenSaya();
  if (dok == null) {
    return;
  }
  await dok.set({'nama': nama}, SetOptions(merge: true));
}

// format uang
var _format2 = NumberFormat.currency(
  locale: 'id_ID',
  symbol: '\$',
  decimalDigits: 2,
);
var _format4 = NumberFormat.currency(
  locale: 'id_ID',
  symbol: '\$',
  decimalDigits: 4,
);
var _format6 = NumberFormat.currency(
  locale: 'id_ID',
  symbol: '\$',
  decimalDigits: 6,
);
var _formatRingkas = NumberFormat.compact(locale: 'id_ID');

// desimal ngikutin harga
String formatHarga(double harga) {
  if (harga >= 1) {
    return _format2.format(harga);
  }
  if (harga >= 0.01) {
    return _format4.format(harga);
  }
  return _format6.format(harga);
}

// 1325000000000 jadi 1,32 T
String formatRingkas(double angka) {
  return _formatRingkas.format(angka);
}
