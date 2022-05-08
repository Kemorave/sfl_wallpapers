import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/action_result.dart';
import '../../core/failur.dart';

class SendResult extends ActionResult<bool> {
  SendResult([Failur? failur, bool? result]) : super(failur, result);
}

class ResetPasswordRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<SendResult> resetPassword(String code, String newPassword) async {
    try {
      _auth.confirmPasswordReset(code: code, newPassword: newPassword);
      return SendResult(null, true);
    } on FirebaseAuthException catch (e) {
      return SendResult(Failur(null, e.message, e.code, Icons.error), false);
    } catch (e) {
      return SendResult(Failur(null, "Error", "", Icons.error), false);
    }
  }

  Future<SendResult> verifyPasswordResetCode(String code, String email) async {
    try {
      if (await _auth.verifyPasswordResetCode(code) == email) {
        return SendResult(null, true);
      }
      return SendResult(Failur(null, "Invalid code"), false);
    } on FirebaseAuthException catch (e) {
      return SendResult(Failur(null, e.message, e.code, Icons.error), false);
    } catch (e) {
      return SendResult(Failur(null, "Error", "", Icons.error), false);
    }
  }

  Future<SendResult> sendResetPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      return SendResult(null, true);
    } on FirebaseAuthException catch (e) {
      return SendResult(Failur(null, e.message, e.code, Icons.error), false);
    } catch (e) {
      return SendResult(Failur(null, "Error", "", Icons.error), false);
    }
  }
}
