import 'package:get/get.dart';
import 'package:sfl/app/data/repositories/reset_password_repository.dart';

import 'reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetPasswordRepository());
    Get.delete<ResetPasswordController>();
    Get.put<ResetPasswordController>(
      ResetPasswordController(),
    );
  }
}
