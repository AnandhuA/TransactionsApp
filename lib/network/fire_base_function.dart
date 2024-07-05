import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepo {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<String> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return "Password should be at least 6 character";
      } else if (e.code == "email-already-in-use") {
        return "Email already in use";
      } else {
        return "something wrong";
      }
    }
  }

  static Future<String> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        return "Email and password incorrect";
      } else {
        return "Something Worng";
      }
    }
  }
}
