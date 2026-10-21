// model koin, sementara masih data dummy
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Koin {
  String nama;
  String simbol;
  double harga;
  double perubahan24j;
  double kapPasar;
  double volume24j;
  double tertinggi;
  String deskripsi;

  Koin({
    required this.nama,
    required this.simbol,
    required this.harga,
    required this.perubahan24j,
    required this.kapPasar,
    required this.volume24j,
    required this.tertinggi,
    required this.deskripsi,
  });
}

// nanti diganti ambil dari api
List<Koin> daftarKoin = [
  Koin(
    nama: 'Bitcoin',
    simbol: 'BTC',
    harga: 67234.50,
    perubahan24j: -2.31,
    kapPasar: 1325000000000,
    volume24j: 28400000000,
    tertinggi: 68912.00,
    deskripsi: 'Bitcoin adalah mata uang digital pertama, diluncurkan tahun 2009 oleh Satoshi Nakamoto. Jumlah totalnya dibatasi 21 juta koin.',
  ),
  Koin(
    nama: 'Ethereum',
    simbol: 'ETH',
    harga: 3120.80,
    perubahan24j: 1.05,
    kapPasar: 375200000000,
    volume24j: 15800000000,
    tertinggi: 3184.50,
    deskripsi: 'Ethereum adalah platform blockchain yang memperkenalkan smart contract. Ether (ETH) dipakai untuk membayar biaya transaksi di jaringannya.',
  ),
  Koin(
    nama: 'BNB',
    simbol: 'BNB',
    harga: 598.42,
    perubahan24j: 0.47,
    kapPasar: 88400000000,
    volume24j: 1700000000,
    tertinggi: 604.10,
    deskripsi: 'BNB adalah token milik Binance, dipakai untuk membayar biaya transaksi di bursa dan di jaringan BNB Chain.',
  ),
  Koin(
    nama: 'Solana',
    simbol: 'SOL',
    harga: 148.73,
    perubahan24j: 4.12,
    kapPasar: 69500000000,
    volume24j: 3200000000,
    tertinggi: 152.40,
    deskripsi: 'Solana adalah blockchain yang dirancang untuk transaksi cepat dengan biaya rendah. Token aslinya bernama SOL.',
  ),
  Koin(
    nama: 'XRP',
    simbol: 'XRP',
    harga: 0.5231,
    perubahan24j: -0.88,
    kapPasar: 29600000000,
    volume24j: 1100000000,
    tertinggi: 0.5410,
    deskripsi: 'XRP adalah token jaringan Ripple, dipakai untuk mengirim dana antar bank dalam waktu singkat.',
  ),
];

// favorit
Set<String> favorit = {};
var versiFavorit = ValueNotifier(0);

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
}

// format uang pakai intl
var _formatHarga = NumberFormat.currency(locale: 'id_ID', symbol: '\$', decimalDigits: 2);
var _formatRingkas = NumberFormat.compact(locale: 'id_ID');

String formatHarga(double harga) {
  return _formatHarga.format(harga);
}

// 1325000000000 jadi 1,32 T
String formatRingkas(double angka) {
  return _formatRingkas.format(angka);
}
