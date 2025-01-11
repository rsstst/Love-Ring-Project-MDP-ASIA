import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthservices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmaiAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return credential.user;
    } catch (e) {
      print('Error');
    }
    return null;
  }

  Future<User?> signIpWithEmaiAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return credential.user;
    } catch (e) {
      print('Error');
    }
    return null;
  }
}
