import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sfl/app/core/action_result.dart';
import 'package:sfl/app/core/base_controller.dart';
import 'package:sfl/app/core/state_enum.dart';
import 'package:sfl/app/data/repositories/account_repository.dart';

class LoginController extends BaseController {
  final emailErrMessage = "".obs;
  final passwordErrMessage = "".obs;
  final errMessage = "".obs;
  final message = "".obs;
  final hidePass = true.obs;
  var repo = Get.find<LoginRepository>();

  void _continueToHome(ActionResult<UserCredential?> res) async {
    errMessage.value = "";
    if (res.error != null) {
      errMessage.value = res.error?.message ?? "";
    } else {
      state.value = StateEnum.success;
      message.value = "Welcome";
    }
  }

  void signInWithGoogle() async {
    isBusy.value = true;
    errMessage.value = '';
    var res =
        await ActionResult.runAsync<UserCredential?>(repo.signInwithGoogle);
    _continueToHome(res);
    isBusy.value = false;
  }

  void signInWithFacebook() async {
    isBusy.value = true;
    errMessage.value = '';
    var res =
        await ActionResult.runAsync<UserCredential?>(repo.loginByFacebook);
    _continueToHome(res);
    isBusy.value = false;
  }

  bool triggerCheck(String email, String password) {
    bool pass = true;
    if (email == '' || !email.contains("@")) {
      emailErrMessage.value = "Email not correct";
      pass = false;
    } else {
      emailErrMessage.value = "";
    }
    if (password == '' || password.length < 6) {
      passwordErrMessage.value = "Password less than 6 characters";
      pass = false;
    } else {
      passwordErrMessage.value = "";
    }
    return pass;
  }

  void signInWithEmail(String email, String password) async {
    errMessage.value = '';
    if (!triggerCheck(email, password)) return;
    isBusy.value = true;
    var res = await ActionResult.runAsync<UserCredential?>(
        () => repo.loginByEmail(email, password));
    _continueToHome(res);
    isBusy.value = false;
  }
}
