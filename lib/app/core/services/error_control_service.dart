import 'dart:async';
import 'dart:io';

import 'package:sfl/locator.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';

import '../exceptions/network_error_exception.dart';
import '../exceptions/not_loged_in_exception.dart';
import '../failur.dart';

class ErrorControlService extends GetxService {
  Failur getFailur(Object error) {
    if (error is WebSocketException ||
        error is HttpException ||
        error is TimeoutException ||
        error is NetworkErrorException ||
        error is SocketException) {
      return Failur(
          error: error,
          title: language().strings.connectionError,
          message: language().strings.noInternet);
    }
    return Failur.fromError(error, "Unkown");
  }

  bool isFilteredError(error) {
    if (error is WebSocketException ||
        error is HttpException ||
        error is TimeoutException ||
        error is NetworkErrorException ||
        error is SocketException) {
      return true;
    } else if (error is NotLogedInException) {
      return true;
    }
    return false;
  }

  void reportError(Object exception, StackTrace stack) async {
    if (isFilteredError(exception)) {
      return;
    }
    try {
      if (await userService().isLogedIn()) {
        await FirebaseCrashlytics.instance
            .setUserIdentifier(userService().user.id.toString());
      }
      await FirebaseCrashlytics.instance.recordError(exception, stack);

      // ignore: empty_catches
    } catch (e) {}
  }
}
