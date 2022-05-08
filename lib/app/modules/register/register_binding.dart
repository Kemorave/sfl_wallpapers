import 'package:get/get.dart';
import 'package:sfl/app/data/repositories/register_repository.dart';

import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterRepository());
    Get.lazyPut<RegisterController>(
      RegisterController.new,
    );
  }
}
