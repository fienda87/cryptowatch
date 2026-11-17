import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../layanan/api_koin.dart';
import '../model/koin.dart';
import 'widgets/grafik_harga.dart';
import '../../theme/warna.dart';

// detail koin
class LayarDetail extends StatefulWidget {
  const LayarDetail({super.key});

  @override
  State<LayarDetail> createState() => _LayarDetailState();
}

class _LayarDetailState extends State<LayarDetail> {
  String deskripsiApi = '';
  bool memuatDeskripsi = true;
  bool mulai = false;
  bool bukaLebar = false;
  double ath = 0;

  // grafik 24 jam
  List<Titik> titik = [];
  bool memuatGrafik = true;
  String galatGrafik = '';

  // ringkasan
  String teksRingkas() {
    var satuBaris = deskripsiApi.replaceAll('\n', ' ');
    if (satuBaris.length <= 280) {
      return satuBaris;
    }
    return '${satuBaris.substring(0, 280)}...';
  }

  // pecah paragraf
  List<String> daftarParagraf() {
    var hasil = <String>[];
    for (var p in deskripsiApi.split('\n')) {
      if (p.trim() != '') {
        hasil.add(p.trim());
      }
    }
    return hasil;
  }

  // ambil data pas layar dibuka
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!mulai) {
      mulai = true;
      var koin = ModalRoute.of(context)!.settings.arguments as Koin;
      muatInfo(koin.id);
      muatGrafik(koin.id);
    }
  }

  // info dari api
  void muatInfo(String id) async {
    try {
      var info = await ambilInfoKoin(id);
      setState(() {
        deskripsiApi = info['deskripsi'].toString();
        ath = (info['ath'] as num).toDouble();
        memuatDeskripsi = false;
      });
    } catch (e) {
      setState(() {
        memuatDeskripsi = false;
      });
    }
  }

  // grafik dari api
  void muatGrafik(String id) async {
    try {
      var data = await ambilGrafik(id, 1);
      setState(() {
        titik = data;
        memuatGrafik = false;
        galatGrafik = '';
      });
    } catch (e) {
      setState(() {
        memuatGrafik = false;
        galatGrafik = 'Grafik gagal dimuat.';
      });
    }
  }

  Widget kotakStat(String judul, String nilai) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: WarnaApp.permukaan,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: WarnaApp.pemisah, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: TextStyle(color: WarnaApp.teksRedup, fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            nilai,
            style: TextStyle(
              color: WarnaApp.teksUtama,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // notif kecil di atas, biar nggak nutup tombol bawah
  void pesanAtas(String teks, IconData ikon) {
    var overlay = Overlay.of(context);
    var entri = OverlayEntry(
      builder: (c) {
        return Positioned(
          top: MediaQuery.of(c).padding.top + 12,
          left: 16,
          right: 16,
          child: IgnorePointer(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: WarnaApp.permukaanTinggi,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: WarnaApp.pemisah),
              ),
              child: Row(
                children: [
                  Icon(ikon, size: 18, color: WarnaApp.bintang),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      teks,
                      style: TextStyle(
                        color: WarnaApp.teksUtama,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(entri);
    Future.delayed(Duration(seconds: 2), () {
      entri.remove();
    });
  }

  // tambah langsung, hapus konfirmasi dulu
  Future<void> ubahFavoritDetail(Koin koin, bool suka) async {
    if (!suka) {
      ubahFavorit(koin);
      pesanAtas('Berhasil ditambahkan ke pantauan', Icons.star);
      return;
    }

    var setuju = await showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: Text('Hapus dari pantauan?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(c, false);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(c, true);
              },
              child: Text('Hapus', style: TextStyle(color: WarnaApp.rugi)),
            ),
          ],
        );
      },
    );

    if (setuju != true) {
      return;
    }

    ubahFavorit(koin);
    pesanAtas('Berhasil dihapus dari pantauan', Icons.star_border);
  }

  // peringkat
  Widget chipPeringkat(Koin koin) {
    if (koin.peringkat <= 0) {
      return SizedBox();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: WarnaApp.permukaanTinggi,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '#${koin.peringkat}',
        style: TextStyle(
          color: WarnaApp.teksRedup,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var koin = ModalRoute.of(context)!.settings.arguments as Koin;
    var naik = koin.perubahan24j >= 0;
    var warnaUbah = naik ? WarnaApp.untung : WarnaApp.rugi;
    var gaya = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          koin.nama,
          style: TextStyle(
            color: WarnaApp.teksUtama,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: versiFavorit,
            builder: (context, nilai, anak) {
              var suka = disukai(koin);
              return IconButton(
                onPressed: () {
                  ubahFavoritDetail(koin, suka);
                },
                icon: Icon(
                  suka ? Icons.star : Icons.star_border,
                  color: suka ? WarnaApp.bintang : WarnaApp.teksUtama,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // kepala
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: WarnaApp.permukaanTinggi,
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: koin.gambar,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return SizedBox();
                      },
                      errorWidget: (context, url, error) {
                        return Center(
                          child: Text(
                            koin.simbol[0],
                            style: TextStyle(
                              color: WarnaApp.teksUtama,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                koin.nama,
                                style: gaya.headlineSmall?.copyWith(
                                  color: WarnaApp.teksUtama,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 8),
                            chipPeringkat(koin),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          koin.simbol,
                          style: gaya.bodyMedium?.copyWith(
                            color: WarnaApp.teksRedup,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                // harga
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatHarga(koin.harga),
                    style: gaya.headlineMedium?.copyWith(
                      color: WarnaApp.teksUtama,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: warnaUbah.withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${naik ? '+' : ''}${koin.perubahan24j.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: warnaUbah,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Wrap(
                // statistik
                spacing: 8,
                runSpacing: 8,
                children: [
                  kotakStat('Kap Pasar', '\$${formatRingkas(koin.kapPasar)}'),
                  kotakStat('Volume 24j', '\$${formatRingkas(koin.volume24j)}'),
                  kotakStat('ATH', ath > 0 ? formatHarga(ath) : '-'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Grafik harga',
                    style: gaya.titleMedium?.copyWith(
                      color: WarnaApp.teksUtama,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: WarnaApp.permukaanTinggi,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: WarnaApp.pemisah),
                    ),
                    child: Text(
                      '24J',
                      style: TextStyle(
                        color: WarnaApp.teksUtama,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                height: 220,
                padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
                decoration: BoxDecoration(
                  color: WarnaApp.permukaan,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: WarnaApp.pemisah, width: 0.5),
                ),
                child: memuatGrafik
                    ? Center(
                        child: Text(
                          'Memuat grafik...',
                          style: TextStyle(color: WarnaApp.teksRedup),
                        ),
                      )
                    : (galatGrafik != ''
                          ? Center(
                              child: Text(
                                galatGrafik,
                                style: TextStyle(color: WarnaApp.teksRedup),
                              ),
                            )
                          : GrafikHarga(titik: titik, hari: 1, naik: naik)),
              ),
              SizedBox(height: 16),
              Text(
                'Deskripsi',
                style: gaya.titleMedium?.copyWith(
                  color: WarnaApp.teksUtama,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              if (memuatDeskripsi)
                Text(
                  'Memuat deskripsi...',
                  style: TextStyle(color: WarnaApp.teksRedup, fontSize: 14),
                )
              else if (deskripsiApi == '')
                Text(
                  'Deskripsi tidak tersedia.',
                  style: TextStyle(color: WarnaApp.teksRedup, fontSize: 14),
                )
              else if (!bukaLebar)
                Text(
                  teksRingkas(),
                  style: gaya.bodyMedium?.copyWith(
                    color: WarnaApp.teksRedup,
                    height: 1.5,
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var paragraf in daftarParagraf())
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          paragraf,
                          style: gaya.bodyMedium?.copyWith(
                            color: WarnaApp.teksRedup,
                            height: 1.5,
                          ),
                        ),
                      ),
                  ],
                ),
              // buka/tutup
              if (!memuatDeskripsi && deskripsiApi.length > 280)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      bukaLebar = !bukaLebar;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      bukaLebar ? 'Tutup' : 'Baca selengkapnya',
                      style: TextStyle(
                        color: WarnaApp.aksen,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
