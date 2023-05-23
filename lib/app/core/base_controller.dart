import 'package:sfl/app/core/events/on_logout_event.dart';
import 'package:sfl/app/core/failur.dart';
import 'package:sfl/app/core/state_enum.dart';
import 'package:sfl/app/core/vm.dart';
import 'package:sfl/locator.dart';
import 'package:sfl/messenger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'exceptions/not_loged_in_exception.dart';
import 'exceptions/repository_disposed_exception.dart';

class ExceptionsFilerHelper {
  static final ignoreTypesList = [
    "Null check operator used on a null value",
    'Can not emit events to disposed clients'
  ];
}

class BaseController extends GetxController {
  final isBusy = false.obs;
  final state = StateEnum.idle.obs;
  final error = Rx<Failur?>(null);

  Failur getFailurFilter(Object exception) =>
      errorControl().getFailur(exception);

  bool errorIgnoreFilter(Object object) {
    if (object is RepositoryDisposedException) {
      return true;
    }
    return ExceptionsFilerHelper.ignoreTypesList.any((e) =>
        e == object.toString() ||
        (e.runtimeType == object.runtimeType &&
            e.runtimeType != ''.runtimeType));
  }

  void onError(Object exception,
      {StackTrace? stack, bool changeState = true, bool showSnakBar = true}) {
    if (exception is NotLogedInException) {
      Messenger.sendMessage(OnLogoutEvent());
    }
    if (errorIgnoreFilter(exception)) {
      return;
    }
    if (kDebugMode) {
      Get.printError(
          info:
              "Handled error of type (${exception.runtimeType})\n $exception \n=>$stack");
    }
    stack ??= StackTrace.current;
    final failur = getFailurFilter(exception);
    if (changeState) {
      error.value = failur;
      state.value = StateEnum.error;
    }
    if (showSnakBar) {
      ViewModel.tooltip(
          title: failur.title ?? language().strings.unexpectedError,
          icon: const Icon(
            Icons.info,
            color: Colors.white,
          ),
          message: failur.message ?? "...");
    }
    errorControl().reportError(exception, stack);
  }
}
