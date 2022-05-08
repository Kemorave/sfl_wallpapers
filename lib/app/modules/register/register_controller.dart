import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:sfl/app/data/repositories/login_repository.dart';
import 'package:sfl/app/data/repositories/register_repository.dart';

import '../../core/base_controller.dart';

class RegisterController extends BaseController {
  final hidePass = true.obs;

  var repo = Get.find<RegisterRepository>();
  Future<SigninResult> register(String em, String pas) async {
    message.value = "";
    isBusy.value = true;
    var res = await repo.registerNewUser(em, pas);
    if (res.result != null) {
      await Future.delayed(Duration(seconds: 3));
      await Get.defaultDialog(
          textCancel: "Ok",
          onCancel: () {},
          title: "Account created successfully",
          middleText: "Welcome to sfl",
          content: LottieBuilder.asset(
            "assets/success.json",
            height: 200,
            repeat: true,
          ));
    }
    isBusy.value = false;
    return res;
  }
}
