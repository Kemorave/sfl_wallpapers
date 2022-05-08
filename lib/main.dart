import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sfl/app/core/theme/app_par_default_theme.dart';

import 'app/core/bindings/application_bindings.dart';
import 'app/core/theme/main_colors.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SFL',
      theme: ThemeData(
          appBarTheme: AppParDefaultTheme(),
          scaffoldBackgroundColor: MainColors.mainColor,
          primarySwatch: MaterialColor(
            MainColors.mainColor.value,
            <int, Color>{
              50: const Color(0xFFE3F2FD),
              100: const Color(0xFFBBDEFB),
              200: const Color(0xFF90CAF9),
              300: const Color.fromARGB(255, 38, 150, 241),
              400: const Color.fromARGB(255, 0, 104, 189),
              500: Color(MainColors.mainColor.value),
              600: const Color.fromARGB(255, 0, 72, 131),
              700: const Color.fromARGB(255, 2, 58, 114),
              800: const Color.fromARGB(255, 1, 38, 80),
              900: const Color.fromARGB(255, 0, 27, 66),
            },
          )),
      initialBinding: ApplicationBindings(),
      initialRoute: "/splash",
      getPages: AppPages.routes,
    ),
  );
}
