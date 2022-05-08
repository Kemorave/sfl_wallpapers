import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:sfl/app/core/base_controller.dart';
import 'package:sfl/app/core/common_states.dart';
import 'package:sfl/app/data/repositories/login_repository.dart';

class LoginController extends BaseController {
  final emailErrMessage = "".obs;
  final passwordErrMessage = "".obs;
  final errMessage = "".obs;
  final hidePass = true.obs;
  var repo = Get.find<LoginRepository>();
  @override
  void onInit() {
    title.value = "Login";
    super.onInit();
  }

  void _continueToHome(SigninResult? res) async {
    errMessage.value = "";
    if (res == null) return;
    if (res.failur != null) {
      errMessage.value = res.failur?.errorMessage ?? "";
    } else {
      state.value = CommonStates.succes;
      message.value = "Welcome";
    }
  }

  void signInWithGoogle() async {
    isBusy.value = true;
    errMessage.value = '';
    var res = await repo.signInwithGoogle();
    _continueToHome(res);
    isBusy.value = false;
  }

  void signInWithFacebook() async {
    isBusy.value = true;
    errMessage.value = '';
    var res = await repo.loginByFacebook();
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
    var res = await repo.loginByEmail(email, password);
    _continueToHome(res);
    isBusy.value = false;
  }
}
