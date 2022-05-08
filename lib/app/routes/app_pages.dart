import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sfl/app/routes/login_routes.dart';
import 'package:sfl/splash_screen.dart';

import 'home_routes.dart';
import 'reset_password_routes.dart';
import 'register_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/home';
  static String getInitialRout() {
    var v = FirebaseAuth.instance;
    return v.currentUser == null ? "/login" : INITIAL;
  }

  static final routes = [
    ...[
      GetPage(
        name: '/splash',
        page: () => MyCustomSplashScreen(),
      ),
    ],
    ...HomeRoutes.routes,
    ...LoginRoutes.routes,
		...ResetPasswordRoutes.routes,
		...RegisterRoutes.routes,
  ];
}
