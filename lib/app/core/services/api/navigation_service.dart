import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationService extends GetxService {
  Future<T?>? goTo<T>(String path,
      {Map<String, dynamic>? args, bool replace = false}) {
    if (replace) {
      return Get.offNamed<T>(path, arguments: args);
    }
    return Get.toNamed<T>(
      path,
      arguments: args,
      preventDuplicates: false,
    );
  }

  void goBack<T>({T? result, bool pop = true}) {
    Get.back(result: result, canPop: pop );
  }

  void goBackUntil<T>({T? result, required String next}) {
    Get.offNamedUntil(next, (s) => false);
  }

  Future<T?>? dialog<T>(Widget widget,
      {Map<String, dynamic>? args, bool dismisable = true}) {
    return Get.dialog<T>(widget,
        arguments: args, barrierDismissible: dismisable);
  }
}
