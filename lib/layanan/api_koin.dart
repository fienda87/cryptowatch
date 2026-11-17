import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/koin.dart';

// 50 koin teratas
var alamatApi =
    'https://api.coingecko.com/api/v3/coins/markets'
    '?vs_currency=usd&order=market_cap_desc&per_page=50&page=1'
    '&sparkline=false&price_change_percentage=24h';

// ambil koin dari api
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

// deskripsi + ath dari api detail
Future<Map<String, dynamic>> ambilInfoKoin(String id) async {
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

  // paragraf dipisah dulu, baru tag dibuang
  teks = teks.replaceAll(
    RegExp(r'</p>|<br\s*/?>', caseSensitive: false),
    '\n\n',
  );
  teks = teks.replaceAll(RegExp(r'<[^>]*>'), '');

  // rapihin spasi
  var baris = <String>[];
  for (var b in teks.split('\n')) {
    var bersih = b.replaceAll(RegExp(r'[ \t]+'), ' ').trim();
    if (bersih != '') {
      baris.add(bersih);
    }
  }

  var ath = ((data['market_data']?['ath']?['usd'] ?? 0) as num).toDouble();

  return {'deskripsi': baris.join('\n'), 'ath': ath};
}

// titik harga buat grafik
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
