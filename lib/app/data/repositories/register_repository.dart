import 'package:firebase_auth/firebase_auth.dart';

import '../core/errors_info.dart';
import 'login_repository.dart';

class RegisterRepository {
  Future<SigninResult> registerNewUser(String email, String password) async {
    try {
      return SigninResult(
          null,
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email, password: password));
    } on FirebaseAuthException catch (e) {
      return SigninResult(FirebaseFailures.fromCode(e.code));
    }
  }
}
