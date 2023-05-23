import 'package:sfl/app/core/theme/app_theme_data.dart';
import 'package:sfl/locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'failur.dart';

class ViewModel {
  static Future<void> showSuccessDialog(String title, String message) async =>
      await showDialog(title, message, icon: Icons.check_circle);

  static Future<void> showDialog(String title, String message,
      {IconData? icon, Widget? custom}) async {
    await Get.defaultDialog(
      title: title,
      barrierDismissible: false,
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: custom ??
                Icon(
                  icon ?? Icons.warning,
                  color: Get.theme.primaryColor,
                  size: 60,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          )
        ],
      ),
      confirm: ElevatedButton(
          onPressed: () {
            Get.back();
            final FocusScopeNode currentScope = FocusScope.of(Get.context!);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus
                  ?.unfocus(disposition: UnfocusDisposition.scope);
            }
          },
          child: Text(language().strings.ok)),
    );
  }

  static Future<void> showErrorDialog(Failur failur, {IconData? icon}) async {
    await ViewModel.showDialog(failur.title ?? "", failur.message ?? "",
        icon: icon ?? Icons.warning);
  }

  static Future<String> getInput(String title, String message,
      {IconData? icon,
      IconData? keyIcon,
      String? initValue,
      int? maximum,
      TextInputType type = TextInputType.name}) async {
    var result = TextEditingController(text: initValue);
    await Get.defaultDialog(
        title: title,
        barrierDismissible: false,
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon ?? Icons.question_mark,
                size: 80,
                color: Get.theme.primaryColor,
              ),
            ),
            Text(message),
            Container(
                clipBehavior: Clip.hardEdge,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5), blurRadius: 5)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    controller: result,
                    maxLength: maximum,
                    textAlign: TextAlign.center,
                    keyboardType: type,
                    decoration: keyIcon == null
                        ? null
                        : InputDecoration(icon: Icon(keyIcon)),
                  ),
                ))
          ],
        ),
        confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(language().strings.ok)),
        cancel: TextButton(
            onPressed: () {
              result.text = "";
              Get.back();
            },
            child: Text(language().strings.cancel)));
    return result.text;
  }

  static Future<bool> propmote(String title, String message,
      {IconData? icon}) async {
    bool result = false;
    await Get.defaultDialog(
        title: title,
        barrierDismissible: false,
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon ?? Icons.question_mark,
                size: 80,
                color: Get.theme.primaryColor,
              ),
            ),
            Text(message)
          ],
        ),
        confirm: TextButton(
            onPressed: () {
              result = true;
              Get.back();
            },
            child: Text(language().strings.ok)),
        cancel: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(language().strings.cancel)));
    return result;
  }

  static SnackbarController tooltip(
      {String? title,
      required String message,
      Icon? icon,
      Duration? duration}) {
    return Get.showSnackbar(GetSnackBar(
      backgroundColor: CustomColor.primaryColor,
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      title: title ?? language().strings.change,
      icon: icon ??
          const Icon(
            Icons.warning,
            color: Colors.white,
          ),
      duration: duration ?? const Duration(seconds: 2),
    ));
  }

  static SnackbarController snackBar(
      {String? title,
      required String message,
      Icon? icon,
      Duration? duration}) {
    return Get.snackbar(
      title ?? "",
      message,
      backgroundColor: Colors.white,
      icon: icon,
      duration: duration,
      colorText: CustomColor.primaryColor,
    );
  }

  static SnackbarController snackBarSuccess(
      {String? title, required String message, Icon? icon}) {
    return Get.snackbar(
      title ?? "",
      message,
      backgroundColor: Colors.green,
      icon: icon,
      colorText: Colors.white,
    );
  }
}
