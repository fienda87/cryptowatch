import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/koin.dart';

// 50 koin teratas, gratis dan nggak pakai api key
var alamatApi =
    'https://api.coingecko.com/api/v3/coins/markets'
    '?vs_currency=usd&order=market_cap_desc&per_page=50&page=1'
    '&sparkline=false&price_change_percentage=24h';

// ambil data koin dari api, kalau gagal dilempar ke pemanggil
Future<List<Koin>> ambilKoin() async {
  var respon = await http
      .get(Uri.parse(alamatApi))
      .timeout(Duration(seconds: 10));

  if (respon.statusCode != 200) {
    throw 'server balas ${respon.statusCode}';
  }

  var data = jsonDecode(respon.body) as List;
  var hasil = <Koin>[];
  for (var item in data) {
    hasil.add(koinDariJson(item));
  }
  return hasil;
}

// deskripsi panjang dari api detail, tag html-nya dibuang dulu
Future<String> ambilDeskripsi(String id) async {
  var alamat =
      'https://api.coingecko.com/api/v3/coins/$id'
      '?localization=false&tickers=false&community_data=false'
      '&developer_data=false';

  var respon = await http.get(Uri.parse(alamat)).timeout(Duration(seconds: 10));

  if (respon.statusCode != 200) {
    throw 'server balas ${respon.statusCode}';
  }

  var data = jsonDecode(respon.body) as Map;
  var teks = (data['description']?['en'] ?? '').toString();
  teks = teks.replaceAll(RegExp(r'<[^>]*>'), ' ');
  teks = teks.replaceAll(RegExp(r'\s+'), ' ').trim();
  return teks;
}

// titik harga buat grafik, hari = 1, 7, 30, atau 365
Future<List<Titik>> ambilGrafik(String id, int hari) async {
  var alamat =
      'https://api.coingecko.com/api/v3/coins/$id/market_chart'
      '?vs_currency=usd&days=$hari';

  var respon = await http.get(Uri.parse(alamat)).timeout(Duration(seconds: 10));

  if (respon.statusCode != 200) {
    throw 'server balas ${respon.statusCode}';
  }

  var data = jsonDecode(respon.body) as Map;
  var hasil = <Titik>[];
  for (var item in data['prices'] as List) {
    var waktu = DateTime.fromMillisecondsSinceEpoch((item[0] as num).toInt());
    var harga = (item[1] as num).toDouble();
    hasil.add(Titik(waktu, harga));
  }
  return hasil;
}
