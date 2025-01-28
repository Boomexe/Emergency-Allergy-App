import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:emergency_allergy_app/features/authentication/data/models/create_user_req.dart';
import 'package:emergency_allergy_app/features/authentication/data/models/signin_user_req.dart';

import 'package:emergency_allergy_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      final UserCredential credential = await auth.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );

      return const Right('Signin successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      switch (e.code) {
        case 'invalid-credential':
          message = 'The email or password was incorrect.';
          break;
        case 'invalid-email':
          message = 'No user found for that email.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        case 'user-not-found':
          message = 'No account associated with that email.';
          break;
        case 'too-many-requests':
          message = 'Slow down! Try again later.';
          break;

        default:
          print(e.code);
          message = 'An error occurred. Please try again later.';
          break;
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      final UserCredential credential =
          await auth.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      credential.user!.updateDisplayName(createUserReq.displayName);
      FirestoreService.saveUser(createUserReq.displayName);

      return const Right('Signup successful.');
    } on FirebaseAuthException catch (e) {
      String message = '';

      switch (e.code) {
        case 'email-already-in-use':
          message = 'An account already exists with that email.';
          break;
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'invalid-email':
          message = 'The email provided is invalid.';
          break;
        case 'too-many-requests':
          message = 'Slow down! Try again later.';
          break;

        default:
          print(e.code);
          message = 'An error occurred. Please try again later.';
          break;
      }

      return Left(message);
    }
  }

  Future<void> signout() async {
    return await auth.signOut();
  }

  // Future<void> sendPasswordResetEmail(String email) async {
  //   return await auth.sendPasswordResetEmail(email: email);
  // }

  // Future<void> verifyEmail() async {
  //   final User? user = auth.currentUser;
  //   return await user!.sendEmailVerification();
  // }

  // void enrollMfa() async {
  //   final User? user = auth.currentUser;
  //   MultiFactorSession multiFactorSession =
  //       await user!.multiFactor.getSession();
  //   TotpSecret totpSecret =
  //       await TotpMultiFactorGenerator.generateSecret(multiFactorSession);
  //   String url = await totpSecret.generateQrCodeUrl(
  //       accountName: user.uid, issuer: 'Emergency App');
  //   print(url);
  // }

  // void enterEnrollmentMfa() async {
  //   MultiFactorAssertion multiFactorAssertion = await TotpMultiFactorGenerator.getAssertionForEnrollment(totpSecret, oneTimePassword)
  // }

  // Future<void> deleteUser() async {
  //   try {
  //     User? user = auth.currentUser;
  //     if (user != null) {
  //       await user.delete();
  //     } else {
  //       throw Exception('not-signed-in');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception(e.code);
  //   }
  // }

  void updateDisplayName(String name) async {
    User? user = auth.currentUser;
    await user?.updateDisplayName(name);

    FirestoreService.updateUser({'displayName': name});
  }

  // static List<String> getMessageFromErrorCode(String code) {
  //   switch (code) {
  //     case 'invalid-credential':
  //       return [
  //         'Incorrect credential',
  //         'The email or password you provided is incorrect.'
  //       ];
  //     case 'invalid-email':
  //       return ['Invalid email', 'The email address you inputed is invalid.'];
  //     case 'user-not-found':
  //       return [
  //         'User not found',
  //         'We could not find a user associated with that email.'
  //       ];
  //     case 'wrong-password':
  //       return [
  //         'Incorrect password',
  //         'The password you provided was incorrect.'
  //       ];
  //     case 'email-already-in-use':
  //       return [
  //         'Email in use',
  //         'The email address you provided is already in use by another account.'
  //       ];
  //     case 'weak-password':
  //       return ['Weak password', 'The password you provided is too weak.'];
  //     case 'user-disabled':
  //       return ['Account disabled', 'This account has been disabled.'];
  //     case 'network-request-failed':
  //       return ['Network Error', 'The network request failed.'];
  //     default:
  //       return ['Error', 'An error occurred. Code: $code'];
  //   }
  // }
}
