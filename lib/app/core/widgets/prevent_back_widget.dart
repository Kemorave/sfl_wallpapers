import 'package:sfl/app/core/base_controller.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';
import '../vm.dart';

Widget preventBackWidget(
    {required Widget child, required BaseController controller}) {
  return WillPopScope(
      child: child,
      onWillPop: () async {
        if (controller.isBusy.value) {
          ViewModel.tooltip(
              title: language().strings.pleaseWait, message: "...");
        }
        return !controller.isBusy.value;
      });
}
