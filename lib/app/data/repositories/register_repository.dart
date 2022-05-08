import 'package:firebase_auth/firebase_auth.dart';
import 'package:sfl/app/core/failur.dart';

import 'login_repository.dart';

class RegisterRepository {
  Future<SigninResult> registerNewUser(String email, String password) async {
    try {
      return SigninResult(
          null,
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email, password: password));
    } on FirebaseAuthException catch (e) {
      return SigninResult(Failur(null, e.message));
    }
  }
}
