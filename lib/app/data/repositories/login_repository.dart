import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sfl/app/core/failur.dart';
import 'package:sfl/app/core/action_result.dart';

class SigninResult extends ActionResult<UserCredential> {
  SigninResult([Failur? failur, UserCredential? result])
      : super(failur, result);
}

class LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<SigninResult?> signInwithGoogle() async {
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
      return SigninResult(null, await _auth.signInWithCredential(credential));
    } on FirebaseAuthException catch (e) {
      return SigninResult(Failur(null, e.message, e.code, Icons.error), null);
    }
  }

  Future<SigninResult> loginByEmail(String email, String password) async {
    UserCredential? res;
    try {
      res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return SigninResult(null, res);
    } on FirebaseAuthException catch (e) {
      return SigninResult(Failur(null, e.message, e.code, Icons.error), null);
    }
  }

  Future<SigninResult?> loginByFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(result.accessToken!.token);

          return SigninResult(
              null,
              await FirebaseAuth.instance
                  .signInWithCredential(facebookCredential));
        case LoginStatus.cancelled:
          return null;
        case LoginStatus.failed:
          return SigninResult(Failur("Failed", result.message), null);
        default:
          return SigninResult(Failur(), null);
      }
    } on FirebaseAuthException catch (e) {
      return SigninResult(Failur("Fail", e.message), null);
    }
  }
}
