import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../modules/reset_password/reset_password_binding.dart';
import '../modules/reset_password/reset_password_page.dart';

class ResetPasswordRoutes {
  ResetPasswordRoutes._();

  static final routes = [
    GetPage(
      transition: Transition.circularReveal,
      transitionDuration: Duration(milliseconds: 1000),
      curve: Curves.bounceOut,
      name: '/reset-password',
      page: ResetPasswordPage.new,
      binding: ResetPasswordBinding(),
    ),
  ];
}
