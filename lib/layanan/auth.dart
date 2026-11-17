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
