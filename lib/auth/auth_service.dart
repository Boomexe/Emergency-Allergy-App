import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }

  static List<String> getMessageFromErrorCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return ['Incorrect credential', 'The email or password you provided is incorrect.'];
      case'invalid-email':
        return ['Invalid email', 'The email address you inputed is invalid.'];
      case 'user-not-found':
        return ['User not found', 'We could not find a user associated with that email.'];
      case 'wrong-password':
        return ['Incorrect password', 'The password you provided was incorrect.'];
      case 'email-already-in-use':
        return ['Email in use', 'The email address you provided is already in use by another account.'];
      case 'weak-password':
        return ['Weak password', 'The password you provided is too weak.'];
      default:
        return ['Error', 'An error occurred. Code: $code'];
    }
  }
}
