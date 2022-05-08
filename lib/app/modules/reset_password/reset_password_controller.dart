import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sfl/app/core/base_controller.dart';
import 'package:sfl/app/data/repositories/reset_password_repository.dart';

import '../../data/repositories/login_repository.dart';

class ResetPasswordController extends BaseController {
  String _code = "";
  final email = "".obs;
  final viewIndex = 0.obs;
  final hidePass = true.obs;
  var repo = Get.find<ResetPasswordRepository>();

  Future<SendResult> sendResetMessage(String email) async {
    isBusy.value = true;
    this.email.value = email;
    var res = await repo.sendResetPasswordEmail(email);
    if (res.result == true) {
      await Get.defaultDialog(
          textCancel: "Ok",
          onCancel: () {},
          title: "Password reset link sent successfully",
          middleText: "Check your emails for the message",
          content: LottieBuilder.asset(
            "assets/success.json",
            height: 200,
            repeat: false,
          ));
      Get.back();
    }
    //if (res.result == true) viewIndex.value = 1;
    isBusy.value = false;
    return res;
  }

  Future<SendResult> verifyPasswordResetCode(String code) async {
    isBusy.value = true;
    var res = await repo.verifyPasswordResetCode(code, email.value);
    if (res.result == true) {
      _code = code;
      viewIndex.value = 2;
    }
    isBusy.value = false;
    return res;
  }

  Future<SendResult> resetPassword(String newPassword) async {
    isBusy.value = true;
    var res = await repo.resetPassword(_code, newPassword);
    if (res.result == true) {
      await Get.defaultDialog(
          title: "Password reset successfull",
          middleText: "Try logging in with $newPassword again",
          content: LottieBuilder.asset(
            "asset/success.json",
            repeat: false,
          ));
      Get.back();
    }
    isBusy.value = false;
    return res;
  }
}
