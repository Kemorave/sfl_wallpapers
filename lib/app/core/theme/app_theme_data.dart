/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your theme, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// Usage:
/// In order to use this newly created theme or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/theme.dart';`
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_generator/material_color_generator.dart';

import 'main_colors.dart';

class CustomColor {
  static MaterialColor mainColor =
      generateMaterialColor(color: const Color(0xFF0C638D));
  static const Color primaryColor = Color(0xFF0C638D);
  static Color secondaryColor = const Color(0xA30E638D);
  static Color thirdColor = const Color(0x510E638D);

  static Color accentColor = const Color(0xFFf8f8f8);
  static Color yellowLightColor = const Color(0xFFFDF5E6);
  static Color redDarkColor = const Color(0xFF2B0100);
  static Color redColor = const Color(0xFFD90404);
  static Color greyColor = const Color(0xFF707070);
  static Color listBackgroundGreyColor = const Color(0xFFEDF0F6);
  static Color categoryBackground = const Color(0xFFF7F9FC);

  static Color lightGreenColor = const Color(0xFF1CB281);
  static Color moreLightGreenColor = const Color(0xFFB1EFDB);

  static Color darkGreenColor = const Color(0xFF238B76);
  static Color midGreenColor = const Color(0xFF009CA2);

  static Color greenLightColor = const Color(0xFFE5F6E7);
  static Color blueColor = const Color(0xFF307AFF);
}

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
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
      ),
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 10, 141, 82),
          ), //button color
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ), //text (and icon)
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.orange,
          ), //button color
          foregroundColor: MaterialStateProperty.all<Color>(
            const Color(0xffffffff),
          ), //text (and icon)
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(color: Color(0xffffffff)),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.orange,
            ), //button color
            foregroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF000000),
            ) //text (and icon)
            ),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFd21e1d),
    primaryContainer: Color(0xFF9e1718),
    secondary: Color(0xFFEFF3F3),
    secondaryContainer: Color(0xFFFAFBFB),
    background: Color(0xFFE6EBEB),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryContainer: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryContainer: Color(0xFF451B6F),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.normal;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w800;
  static const _bold = FontWeight.w700;

  static final TextTheme textTheme = TextTheme(
    headlineMedium: GoogleFonts.cairo(fontWeight: _bold, fontSize: 12.sp),
    bodySmall: GoogleFonts.cairo(fontWeight: _semiBold, fontSize: 12.0.sp),
    headlineSmall: GoogleFonts.cairo(fontWeight: _medium, fontSize: 12.0.sp),
    titleMedium: GoogleFonts.cairo(fontWeight: _medium, fontSize: 12.0.sp),
    labelSmall: GoogleFonts.cairo(fontWeight: _medium, fontSize: 12.0.sp),
    bodyLarge: GoogleFonts.cairo(
        fontWeight: _regular, fontSize: 12.0.sp, fontStyle: FontStyle.normal),
    titleSmall: GoogleFonts.cairo(fontWeight: _medium, fontSize: 12.0.sp),
    bodyMedium: GoogleFonts.cairo(
        fontWeight: _regular, fontSize: 12.0.sp, fontStyle: FontStyle.normal),
    titleLarge: GoogleFonts.cairo(fontWeight: _bold, fontSize: 12.0.sp),
    labelLarge: GoogleFonts.cairo(fontWeight: _semiBold, fontSize: 12.0.sp),
  );
}
