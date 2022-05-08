import 'package:get/get.dart';
import 'package:sfl/app/modules/login/login_binding.dart';

import '../modules/login/login_page.dart';

class LoginRoutes {
  LoginRoutes._();

  static final routes = [
    GetPage(
      transition: Transition.rightToLeft,
      name: '/login',
      page: LoginPage.new,
      binding: LoginBinding(),
    ),
  ];
}
