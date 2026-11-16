// model koin, datanya diambil dari api coingecko
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

// satu titik di grafik harga
class Titik {
  Titik(this.waktu, this.harga);

  DateTime waktu;
  double harga;
}

// diisi dari api, kosong dulu sebelum data datang
List<Koin> daftarKoin = [];

// satu data json dari coingecko jadi Koin
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

// favorit, disimpan biar nggak hilang pas app ditutup
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
}

// format uang pakai intl
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

// koin mahal 2 desimal, koin murah 4 atau 6 desimal
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
