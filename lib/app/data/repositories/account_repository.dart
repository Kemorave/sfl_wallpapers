import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sfl/app/core/failur.dart';
import 'package:sfl/app/data/repositories/base/i_disposible_repository.dart';

import '../../core/errors_info.dart';

class LoginRepository extends IDisposibleRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  Future<UserCredential> registerNewUser(String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return throw (FirebaseFailures.fromCode(e.code));
    }
  }

  Future<UserCredential?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null;
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      return throw (FirebaseFailures.fromCode(e.code));
    }
  }

  Future<UserCredential> loginByEmail(String email, String password) async {
    UserCredential? res;
    try {
      res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return res;
    } on FirebaseAuthException catch (e) {
      throw (FirebaseFailures.fromCode(e.code));
    }
  }

  Future<UserCredential?> loginByFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(result.accessToken!.token);

          return await FirebaseAuth.instance
              .signInWithCredential(facebookCredential);
        case LoginStatus.cancelled:
          return null;
        case LoginStatus.failed:
          throw Failur(
              title: "Login Failed",
              message: result.message,
              errorCode: LoginStatus.failed.toString());
        default:
          throw Failur(
              title: "Login Failed",
              message: result.message,
              errorCode: LoginStatus.failed.toString());
      }
    } on FirebaseAuthException catch (e) {
      throw (FirebaseFailures.fromCode(e.code));
    }
  }

  Future<void> resetPassword(String code, String newPassword) async {
    return _auth.confirmPasswordReset(code: code, newPassword: newPassword);
  }

  Future<bool> verifyPasswordResetCode(String code, String email) async {
    if (await _auth.verifyPasswordResetCode(code) == email) {
      return true;
    }
    return false;
  }

  Future<void> sendResetPasswordEmail(String email) async {
    return _auth.sendPasswordResetEmail(
      email: email,
    );
  }
}
