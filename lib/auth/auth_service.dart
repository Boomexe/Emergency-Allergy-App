import 'dart:async';

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
      String email, String password, String name) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userCredential.user?.updateDisplayName(name);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> verifyEmail() async {
    final User? user = auth.currentUser;
    return await user!.sendEmailVerification();
  }

  void enrollMfa() async {
    final User? user = auth.currentUser;
    MultiFactorSession multiFactorSession = await user!.multiFactor.getSession();
    TotpSecret totpSecret = await TotpMultiFactorGenerator.generateSecret(multiFactorSession);
    String url = await totpSecret.generateQrCodeUrl(accountName: user.uid, issuer: 'Emergency App');
    print(url);
  }

  // void enterEnrollmentMfa() async {
  //   MultiFactorAssertion multiFactorAssertion = await TotpMultiFactorGenerator.getAssertionForEnrollment(totpSecret, oneTimePassword)
  // }

  Future<void> deleteUser() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await user.delete();
      } else {
        throw Exception('not-signed-in');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  User? getSignedInUser() {
    User? user = auth.currentUser;

    return user;
  }

  void updateDisplayName(String name) {
    User? user = auth.currentUser;
    user?.updateDisplayName(name);
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
      case 'user-disabled':
        return ['Account disabled', 'This account has been disabled.'];
      case 'network-request-failed':
        return ['Network Error', 'The network request failed.'];
      default:
        return ['Error', 'An error occurred. Code: $code'];
    }
  }
}
