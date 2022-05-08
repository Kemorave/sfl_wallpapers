import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    FirebaseAuth.instance.userChanges().listen((user) async {
      if (Get.currentRoute == "/splash") return;
      if (user == null) {
        Get.offAllNamed('/login');
      } else {
        await Future.delayed(const Duration(seconds: 2));
        Get.offAllNamed('/home');
      }
    });
  }
}
