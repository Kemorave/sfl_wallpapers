import 'package:get/get.dart';
import 'package:sfl/app/data/repositories/login_repository.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginRepository());
    Get.lazyPut<LoginController>(
      LoginController.new,
    );
  }
}
