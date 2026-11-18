# Checklist rilis Play Store â€” CryptoWatch

Urut dari atas. Centang satu per satu.

## A. Yang sudah siap di proyek
- [x] Package unik `com.cryptowatch1187.app`
- [x] `version: 1.0.0+1` di pubspec
- [x] Izin INTERNET di AndroidManifest
- [x] Keystore + `key.properties` + signing release di Gradle
- [x] `targetSdk 36`
- [x] AAB release: `build/app/outputs/bundle/release/app-release.aab`
- [x] Ikon Play 512 (`store/ikon-512.png`)
- [x] Feature graphic 1024x500 (`store/grafis-fitur-1024x500.jpg`)
- [x] Teks listing (`store/listing.md`)
- [x] Kebijakan privasi (`docs/privasi.html`)
- [x] Halaman hapus akun (`docs/hapus-akun.html`)
- [x] Fitur Hapus akun di dalam app (Pengaturan)
- [x] Screenshot 4 buah 1080x2160 (store/screenshot-1..4.jpg)
- [x] Firestore database dibuat + rules publish

## B. Yang harus dikerjakan di akun/console (kamu)
1. Aktifkan GitHub Pages: repo `cryptowatch` â†’ Settings â†’ Pages â†’ Branch `main`, folder `/docs` â†’ Save. Tunggu 2 menit, cek `https://fienda87.github.io/cryptowatch/privasi.html` terbuka.
2. Play Console â†’ Create app:
   - Nama: `CryptoWatch: Harga Kripto`
   - Bahasa: Indonesia, App, Free
3. Dashboard â†’ "Set up your app" sampai semua centang hijau:
   - App access: login required â†’ isi email + sandi akun uji
   - Ads: No
   - Content rating: isi kuesioner (jawaban di `store/listing.md`)
   - Target audience: 18+
   - Data safety: jawaban di `store/listing.md`
   - Government apps: No
   - Financial features: informasi saja, bukan layanan keuangan
   - Privacy policy: URL di atas
4. Store listing: isi nama, deskripsi singkat, deskripsi lengkap, upload ikon + feature graphic + 4 screenshot.
5. Test and release â†’ Testing â†’ Internal testing â†’ Create release:
   - Upload `app-release.aab`
   - Play App Signing: ikuti (pakai upload key yang sudah ada)
   - Tambah tester (email kamu sendiri), roll out, install dari link opt-in â†’ pastikan login Google & email jalan di build dari Play.
6. Closed testing: upload AAB yang sama, tambah minimal 12 tester, minta mereka opt-in dan **jangan keluar 14 hari**.
7. Hari ke-14: Dashboard â†’ Apply for production access â†’ jawab 3 bagian â†’ tunggu review (biasanya â‰¤ 7 hari).
8. Production â†’ Create release dari AAB yang sama â†’ review â†’ terbit.

## C. Jebakan yang sering bikin ditolak
- Data safety tidak cocok dengan kenyataan (aplikasi pakai login + Firestore â†’ wajib dideklarasikan).
- Screenshot menampilkan fitur yang tidak ada, atau ada tulisan "gratis/terbaik".
- Kebijakan privasi tidak bisa dibuka tanpa login / berupa PDF.
- Akun uji untuk reviewer tidak bisa dipakai login.
- Nama aplikasi mengandung merek lain. `CryptoWatch` umum dipakai; kalau ditolak, ganti nama listing (package tidak bisa diubah setelah rilis).
- Firestore rules masih mode test atau belum dibuat â†’ login tetap jalan tapi pantauan tidak tersimpan di awan.
