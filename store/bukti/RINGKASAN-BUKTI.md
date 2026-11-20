# Bukti Teknis untuk Dosen — CryptoWatch

Semua perintah dijalankan di `C:\Users\acerr\Documents\papb_crypto`. Hasil mentah ada di folder `store\bukti\`.

---

## 1. Konfigurasi Firebase/Google sudah aktif

**Bukti berkas**
```powershell
Select-String -Path android\app\google-services.json -Pattern "package_name|project_id"
Select-String -Path android\app\build.gradle.kts -Pattern "google-services|applicationId|signingConfigs"
```
Hasil: `package_name = com.cryptowatch1187.app`, `project_id = crypto-fc108`, plugin `com.google.gms.google-services` terpasang, `applicationId = com.cryptowatch1187.app`.

**Bukti runtime (paling kuat)**
- Login email berhasil → Firebase Console → **Authentication → Users** menampilkan akun tersebut
- Login Google berhasil di build Play → berarti OAuth client + SHA-1 terdaftar
- Nama/pantauan tersimpan → Firebase Console → **Firestore → users/{uid}**

**Screenshot yang perlu diambil:** halaman Users di Firebase Authentication + dokumen `users/{uid}` di Firestore.

---

## 2. Keystore/upload key benar-benar dipakai

```powershell
$env:JAVA_HOME="C:\Program Files\Android\Android Studio\jbr"
& "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -list -v -keystore android\upload-keystore.jks
```
Hasil (`store\bukti\` dan terminal):
- Alias: `upload`, `PrivateKeyEntry`
- Owner: `CN=CryptoWatch, OU=PAPB, O=Mahasiswa, L=Bandung, ST=Jawa Barat, C=ID`
- Valid: 18 Nov 2026 – 5 Apr 2054
- SHA1: `2D:06:7F:9B:0A:CE:82:6E:E8:71:28:17:9C:04:D7:AE:B9:E1:58:48`

Bukti kunci ini yang menandatangani APK:
```powershell
& "$env:LOCALAPPDATA\Android\Sdk\build-tools\36.0.0\apksigner.bat" verify --print-certs build\app\outputs\flutter-apk\app-release.apk
```
Hasil: `Signer #1 certificate DN: CN=CryptoWatch, ...` — **bukan** `CN=Android Debug`. SHA-1 sama persis dengan keystore di atas.

Catatan penting untuk dosen: `android\upload-keystore.jks` dan `android\key.properties` **tidak ada di GitHub** (lihat `.gitignore`), hanya ada di komputer.

---

## 3. Build yang dirilis adalah release, bukan debug

```powershell
& "$env:LOCALAPPDATA\Android\Sdk\build-tools\36.0.0\aapt2.exe" dump badging build\app\outputs\flutter-apk\app-release.apk
& "$env:LOCALAPPDATA\Android\Sdk\build-tools\36.0.0\aapt2.exe" dump xmltree --file AndroidManifest.xml build\app\outputs\flutter-apk\app-release.apk | Select-String debuggable
```
Hasil:
- `package: name='com.cryptowatch1187.app' versionCode='1' versionName='1.0.0'`, `targetSdkVersion:'36'`
- Pencarian `debuggable` → **tidak ada hasil** (build debug selalu punya `android:debuggable="true"`)
- Sertifikat: `CN=CryptoWatch` (build debug ditandatangani `CN=Android Debug`)

Berkas hasil build:
- `build\app\outputs\bundle\release\app-release.aab` (untuk Play)
- `build\app\outputs\flutter-apk\app-release.apk` (untuk dipasang langsung)

Perintah build:
```powershell
flutter build appbundle --release
flutter build apk --release
```

---

## 4. Aset gambar dan lisensi

### Yang benar-benar ikut masuk ke aplikasi
`pubspec.yaml` hanya membundel satu aset: `assets/icon/app_icon.png` (logo buatan sendiri, dipakai untuk ikon launcher).

Verifikasi:
```powershell
Select-String -Path pubspec.yaml -Pattern "^  assets:" -Context 0,4
```

### Yang tidak dibundel
- `assets\images\produk.jpg` — ada di folder tapi **tidak** terdaftar di `pubspec.yaml`, jadi tidak ikut ke APK. Aman, tapi sebaiknya dihapus biar tidak salah paham.
- `assets\icon\sda.png` — 0 KB, sampah, hapus saja.
- Logo koin (BTC/ETH/dst) **diunduh saat runtime** dari CoinGecko (`cached_network_image`), tidak disimpan di repo. Jadi tidak ada redistribusi gambar pihak ketiga.

### Lisensi pihak ketiga yang dipakai
| Komponen | Lisensi | Diambil dari |
|---|---|---|
| Flutter SDK + Material Icons | Apache 2.0 | SDK, ikut build |
| google_fonts (Inter) | SIL OFL 1.1 | diunduh runtime dari Google Fonts |
| fl_chart | MIT | pub.dev |
| firebase_core, firebase_auth, cloud_firestore | BSD-3 | pub.dev |
| cached_network_image | MIT | pub.dev |
| shared_preferences, intl, http | BSD-3 | pub.dev |
| CoinGecko API + logo koin | Syarat penggunaan CoinGecko | atribusi wajib |

Cara mengecek lisensi tiap paket (bisa ditunjukkan di depan dosen):
```powershell
flutter pub deps --style=compact
```
lalu buka `https://pub.dev/packages/<nama-paket>/license`, contoh `https://pub.dev/packages/fl_chart/license`.

Atribusi CoinGecko yang sudah terpasang di app: footer halaman **Pengaturan** → "Data harga dari CoinGecko API". Ini syarat free API CoinGecko (https://www.coingecko.com/en/api_terms).

### Yang belum ada (jujur, untuk perbaikan berikutnya)
Halaman **Lisensi** di dalam app (memakai `showLicensePage`) belum dibuat, jadi daftar lisensi otomatis Flutter belum bisa dibuka pengguna. Material Icons berlisensi Apache 2.0 yang secara teknis minta atribusi. Untuk tugas ini masih wajar karena komponen diambil lewat pub.dev, tapi kalau ingin rapi: tambah satu baris "Lisensi" di Pengaturan → `showLicensePage(...)`.

---

## Ringkasan satu halaman untuk presentasi

| Klaim | Alat bukti |
|---|---|
| Firebase aktif | `google-services.json` + Firebase Console → Authentication → Users |
| Key dipakai | `keytool -list -v -keystore android\upload-keystore.jks` + `apksigner verify --print-certs` |
| Release, bukan debug | `aapt2 dump badging` (versionName 1.0.0) + tidak ada `debuggable` + sertifikat `CN=CryptoWatch` |
| Aset aman | `pubspec.yaml` hanya membundel `app_icon.png`; logo koin dari API; lisensi paket di pub.dev |
| Atribusi data | footer Pengaturan "Data harga dari CoinGecko API" |
| Sudah terbit | Play Console status release 1.0.0 (internal/closed testing) |
