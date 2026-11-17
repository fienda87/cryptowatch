import 'dart:async';

import 'package:flutter/material.dart';

import '../layanan/api_koin.dart';
import '../model/koin.dart';
import 'widgets/baris_koin.dart';
import 'widgets/kerangka_koin.dart';
import '../../theme/warna.dart';

class LayarPasar extends StatefulWidget {
  const LayarPasar({super.key});

  @override
  State<LayarPasar> createState() => _LayarPasarState();
}

class _LayarPasarState extends State<LayarPasar> {
  int pilih = 0; // 0 semua, 1 naik, 2 anjlok
  String cari = '';
  bool memuat = true;
  String galat = '';
  Timer? tundaCari;
  Timer? jamRefresh;

  @override
  void initState() {
    super.initState();
    muatKoin();
    // refresh tiap 5 menit
    jamRefresh = Timer.periodic(Duration(minutes: 5), (t) {
      if (daftarKoin.isNotEmpty) {
        muatKoin(paksa: true);
      }
    });
  }

  @override
  void dispose() {
    tundaCari?.cancel();
    jamRefresh?.cancel();
    super.dispose();
  }

  // ambil dari api

  Future<void> muatKoin({bool paksa = false}) async {
    if (!paksa && daftarKoin.isNotEmpty) {
      setState(() {
        memuat = false;
        galat = '';
      });
      return;
    }

    if (!paksa) {
      setState(() {
        memuat = true;
        galat = '';
      });
    }

    try {
      var data = await ambilKoin();
      setState(() {
        daftarKoin = data;
        memuat = false;
        galat = '';
      });
    } catch (e) {
      setState(() {
        memuat = false;
        // data lama dipakai
        if (daftarKoin.isEmpty) {
          galat = 'Gagal ambil data. Cek internet, lalu coba lagi.';
        }
      });
    }
  }

  void bukaDetail(BuildContext context, Koin koin) {
    Navigator.pushNamed(context, '/detail', arguments: koin);
  }

  @override
  Widget build(BuildContext context) {
    if (memuat) {
      return ListView(
        padding: EdgeInsets.all(16),
        children: [for (var i = 0; i < 10; i++) KerangkaKoin()],
      );
    }

    if (galat != '') {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                galat,
                textAlign: TextAlign.center,
                style: TextStyle(color: WarnaApp.teksRedup),
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: muatKoin,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: WarnaApp.aksen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Coba lagi',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // saring
    var hasil = daftarKoin;
    if (pilih == 1) {
      hasil = daftarKoin.where((k) => k.perubahan24j > 0).toList();
      hasil.sort((a, b) => b.perubahan24j.compareTo(a.perubahan24j));
    } else if (pilih == 2) {
      hasil = daftarKoin.where((k) => k.perubahan24j < 0).toList();
      hasil.sort((a, b) => a.perubahan24j.compareTo(b.perubahan24j));
    }

    // cari
    if (cari != '') {
      var kata = cari.toLowerCase();
      hasil = hasil
          .where(
            (k) =>
                k.nama.toLowerCase().contains(kata) ||
                k.simbol.toLowerCase().contains(kata),
          )
          .toList();
    }

    // tarik buat refresh
    return RefreshIndicator(
      onRefresh: () async {
        await muatKoin(paksa: true);
      },
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
        children: [
          TextField(
            style: TextStyle(color: WarnaApp.teksUtama, fontSize: 14),
            onChanged: (teks) {
              // tunggu 300ms
              tundaCari?.cancel();
              tundaCari = Timer(Duration(milliseconds: 300), () {
                setState(() {
                  cari = teks.trim();
                });
              });
            },
            decoration: InputDecoration(
              hintText: 'Cari koin...',
              hintStyle: TextStyle(color: WarnaApp.teksRedup, fontSize: 14),
              prefixIcon: Icon(
                Icons.search,
                color: WarnaApp.teksRedup,
                size: 20,
              ),
              filled: true,
              fillColor: WarnaApp.permukaan,
              isDense: true,
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 12),

          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _chip('Semua', 0),
                _chip('Naik', 1),
                _chip('Anjlok', 2),
              ],
            ),
          ),

          SizedBox(height: 8),
          Text(
            'Daftar Koin',
            style: TextStyle(
              color: WarnaApp.teksUtama,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),

          // list koin
          if (hasil.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  cari == ''
                      ? 'Belum ada koin di filter ini'
                      : 'Koin tidak ketemu',
                  style: TextStyle(color: WarnaApp.teksRedup),
                ),
              ),
            ),
          for (var koin in hasil)
            GestureDetector(
              onTap: () {
                bukaDetail(context, koin);
              },
              child: BarisKoin(koin: koin),
            ),
        ],
      ),
    );
  }

  Widget _chip(String teks, int nomor) {
    var aktif = pilih == nomor;
    return GestureDetector(
      onTap: () {
        setState(() {
          pilih = nomor;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: aktif ? WarnaApp.permukaanTinggi : WarnaApp.permukaan,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: WarnaApp.pemisah),
        ),
        child: Text(
          teks,
          style: TextStyle(
            color: aktif ? WarnaApp.teksUtama : WarnaApp.teksRedup,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
