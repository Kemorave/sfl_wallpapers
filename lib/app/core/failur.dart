import 'package:flutter/widgets.dart';

class Failur {
  final String? title;
  final String? message;
  final Object? error;
  final IconData? icon;
  final String? errorCode;
  static Failur fromError(Object error, String? msg) =>
      Failur(error: error, message: msg);
  Failur({this.message, this.title, this.error, this.errorCode, this.icon});
}
