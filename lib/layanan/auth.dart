import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// urusan login

Future<UserCredential> masukFirebase(String email, String sandi) {
  return FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: sandi,
  );
}

Future<UserCredential> daftarFirebase(String email, String sandi) {
  return FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: sandi,
  );
}

Future<void> keluarFirebase() {
  return FirebaseAuth.instance.signOut();
}

// hapus akun sekalian datanya
Future<String> hapusAkun() async {
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return 'Belum masuk.';
  }

  try {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
  } catch (e) {
    // data awan gagal dihapus, akun tetap lanjut dihapus
  }

  try {
    await user.delete();
    return '';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      return 'Demi keamanan, keluar lalu masuk lagi, baru hapus akun.';
    }
    return 'Gagal hapus akun: ${e.message}';
  }
}

// login google
Future<UserCredential?> masukGoogle() async {
  var google = GoogleSignIn(scopes: ['email']);
  var akun = await google.signIn();
  if (akun == null) {
    return null; // user menutup popup
  }

  var auth = await akun.authentication;
  var kredensial = GoogleAuthProvider.credential(
    accessToken: auth.accessToken,
    idToken: auth.idToken,
  );
  return FirebaseAuth.instance.signInWithCredential(kredensial);
}

// error firebase versi manusia
String pesanAuth(Object e) {
  if (e is FirebaseAuthException) {
    if (e.code == 'invalid-email') {
      return 'Format email salah.';
    }
    if (e.code == 'user-not-found') {
      return 'Email belum terdaftar.';
    }
    if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
      return 'Email atau sandi salah.';
    }
    if (e.code == 'email-already-in-use') {
      return 'Email sudah dipakai.';
    }
    if (e.code == 'weak-password') {
      return 'Sandi minimal 6 karakter.';
    }
    if (e.code == 'network-request-failed') {
      return 'Tidak ada internet.';
    }
    if (e.code == 'too-many-requests') {
      return 'Terlalu banyak percobaan. Coba lagi nanti.';
    }
    return 'Gagal: ${e.message}';
  }
  return 'Terjadi kesalahan.';
}
