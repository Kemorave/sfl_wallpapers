import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppParDefaultTheme extends AppBarTheme {
  AppParDefaultTheme()
      : super(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          backgroundColor: Colors.white.withOpacity(.08),
          elevation: 0,
        );
}
