# Panduan Manual Rilis Play Console — CryptoWatch

Berkas yang dipakai:
- AAB: `build\app\outputs\bundle\release\app-release.aab` (versionCode 1, versionName 1.0.0)
- Ikon: `store\ikon-512.png`
- Feature graphic: `store\grafis-fitur-1024x500.jpg`
- Screenshot: `store\screenshot-1.jpg` sampai `screenshot-4.jpg`
- Teks listing: `store\listing.md`
- Privasi: https://fienda87.github.io/cryptowatch/privasi.html
- Hapus akun: https://fienda87.github.io/cryptowatch/hapus-akun.html

Buka https://play.google.com/console , pilih app **CryptoWatch: Pantau Kripto**.

---

## Langkah 0 — buat akun uji untuk reviewer

Buka app CryptoWatch di HP → **Daftar** → email `reviewer.cryptowatch@gmail.com`, sandi `PantauKripto2026`.
Akun ini yang dipakai reviewer Google untuk masuk. Kalau tidak ada, review ditolak.

---

## Langkah 1 — App content (menu kiri: Policy → App content)

Isi semuanya sampai 11/11 hijau.

| Bagian | Jawaban |
|---|---|
| Privacy policy | `https://fienda87.github.io/cryptowatch/privasi.html` |
| App access | **All or some functionality is restricted** → Add instructions → "Login required. Email: reviewer.cryptowatch@gmail.com Password: PantauKripto2026" |
| Ads | **No** |
| Content rating | Kategori **Utility, productivity, communication or other**; semua pertanyaan jawab **No** |
| Target audience | **18 and over** saja |
| News app | **No** |
| Data safety | **Yes** → Email (Account management, App functionality), Name (Account management), App activity → Other actions (App functionality) → encrypted **Yes** → delete **Yes** + URL hapus akun |
| Government apps | **No** |
| Financial features | **None of the above** |
| Health apps | **No** |
| Advertising ID | **No** |

---

## Langkah 2 — Store listing (Grow → Store presence → Main store listing)

- App name: `CryptoWatch: Pantau Kripto`
- Short description (80): `Pantau harga kripto, grafik 24 jam, dan daftar koin favorit.`
- Full description: salin dari `store\listing.md`
- App icon: `store\ikon-512.png`
- Feature graphic: `store\grafis-fitur-1024x500.jpg`
- Phone screenshots: 4 berkas `store\screenshot-1..4.jpg` (urut 1→4)
- Save

---

## Langkah 3 — Play App Signing + upload AAB

Test and release → Testing → **Internal testing** → **Create new release**

1. Play App Signing: pilih **Use Play App Signing** / Continue (kunci upload kamu otomatis dipakai, tidak perlu unggah keystore)
2. Upload AAB → tunggu "App bundle uploaded"
3. Release notes: `Rilis pertama: daftar harga kripto, detail koin, grafik 24 jam, dan daftar pantauan.`
4. Next → **Save** → **Review release** → **Start rollout to Internal testing** → konfirmasi

---

## Langkah 4 — tester internal

Masih di Internal testing → tab **Testers** → **Create email list**
Nama: `tester-risky` → email: `alfienda170902@gmail.com`, `11231087@student.itk.ac.id` → Save → centang list → Save.

Salin **opt-in URL** → buka di HP → Accept → Install.

---

## Langkah 5 — daftarkan SHA-1 Play ke Firebase (WAJIB untuk login Google)

Play menandatangani ulang app dengan kunci Play, jadi SHA-1 berubah.

1. Play Console → **Test and release → Setup → App signing** → salin **SHA-1 certificate fingerprint**
2. Firebase Console → project `crypto-fc108` → Project settings → app `com.cryptowatch1187.app` → **Add fingerprint** → tempel → Save
3. Tunggu 5–10 menit → tes login Google di app hasil install dari Play

Kalau login Google tetap gagal: hapus app, install ulang dari link opt-in (Play kadang menyajikan APK lama).

---

## Langkah 6 — tes app versi Play

1. Login email `reviewer.cryptowatch@gmail.com` → harus masuk
2. Login Google → harus masuk
3. Bintang 1 koin → tutup app → buka lagi → koin masih berbintang
4. Hapus akun di Pengaturan → harus kembali ke layar login

---

## Langkah 7 — closed testing (gerbang 14 hari)

Test and release → Testing → **Closed testing** → **Create track**

1. Upload AAB yang sama (versionCode 1 boleh dipakai ulang)
2. Release notes sama
3. Tab Testers → tambah minimal **12 email** (teman/kakak/adik; boleh email kampus)
4. Rollout → kirim opt-in link ke mereka → wajib opt-in dan **tidak uninstall/keluar selama 14 hari berturut-turut**

Hitung mundur dimulai saat tester ke-12 opt-in. Kalau ada yang keluar, hitungan bisa mundur.

---

## Langkah 8 — production access

Setelah 14 hari: Dashboard → **Apply for production access** → isi 3 bagian (deskripsi app, kesiapan, cara tester memakai) → submit → review biasanya ≤7 hari.

---

## Yang masih butuh admin kampus

- **Declare your trader status** (banner biru di Dashboard) — hanya owner akun.
- Kalau mau memakai MCP: invite `play-mcp@papb-b1710.iam.gserviceaccount.com` di Users and permissions.

---

## Kalau ditolak review, penyebab tersering

- Akun uji reviewer tidak bisa login / password salah
- Data safety tidak sesuai kenyataan (app jelas punya login + penyimpanan)
- Screenshot menampilkan fitur yang tidak ada
- Kebijakan privasi tidak bisa dibuka
- Klaim "terbaik/gratis/aman" di deskripsi
- Tidak menyelesaikan Declare your trader status
