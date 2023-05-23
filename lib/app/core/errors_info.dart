import 'package:flutter/material.dart';
import 'package:sfl/app/core/failur.dart';

class _FirebaseErrors {
  static const String firebaseAuthException = "Authentication failed";
  static const String firebaseLoginException = "Login failed";
  static const String firebaseRegistrationException = "Registration failed";
}

class _FirebaseCodeErrors {
  static const String wrongPassword = "auth/invalid-password";
  static const String emailAlreadyExist = "auth/email-already-exists";
  static const String firebaseAuth = "auth/invalid-credential";
}

class FirebaseFailures {
  static Failur wrongPasswordFailur = Failur(
      title: _FirebaseErrors.firebaseRegistrationException,
      message: "The provided email is already in use by an existing user.",
      errorCode: _FirebaseCodeErrors.emailAlreadyExist,
      icon: Icons.email);

  static Failur wrongEmailFailur = Failur(
      title: _FirebaseErrors.firebaseLoginException,
      message: "The password is invalid.",
      errorCode: _FirebaseCodeErrors.wrongPassword,
      icon: Icons.password_rounded);

  static Failur serverAuthFailur = Failur(
      title: _FirebaseErrors.firebaseAuthException,
      message: "Authentication error occured",
      errorCode: _FirebaseCodeErrors.firebaseAuth,
      icon: Icons.cloud_off);

  static final _lst = <Failur>[
    wrongPasswordFailur,
    wrongEmailFailur,
    serverAuthFailur,
  ];
  static Failur fromCode(String code) => _lst
      .firstWhere((e) => e.errorCode == code, orElse: () => serverAuthFailur);
}
