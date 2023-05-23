 
import 'dart:isolate';
 
import 'package:sfl/app/core/utils/device_util.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:sfl/locator.dart';
import 'package:get/get.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/core/services/api/cached_local_data_service.dart';
import 'firebase_options.dart';
import 'app/core/bindings/application_bindings.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart' as ia;
import 'app/core/theme/app_theme_data.dart';
import 'package:cached_annotation/cached_annotation.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;
 
Future<Widget> getApp() async {
  initLocator();
  performance().onInit();
  await localStorage().initStorage();
  await language().loadLocale();
  await userService().loadUser();
  PersistentStorageHolder.storage = CachedLocalDataService();
  final locale = Locale(language().getCurrentLocal());
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = false;
  }
  ia.FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
  return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: language().strings.appName,
          initialBinding: ApplicationBindings(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics().service),
          ],
          defaultTransition: Transition.native,
          supportedLocales: [const Locale('en'), language().defaultLocale],
          theme: ThemeData(
              primaryColor: CustomColor.primaryColor,
              fontFamily: 'Cairo',
              textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF000000),
              ))),
              textTheme: AppThemeData.textTheme,
              snackBarTheme: const SnackBarThemeData(
                  actionTextColor: Colors.red,
                  backgroundColor: Colors.black,
                  contentTextStyle: TextStyle(color: Colors.white),
                  elevation: 20)),
          locale: locale,
          fallbackLocale: language().defaultLocale,
          localizationsDelegates: [
            language().locale,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      });
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
 
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    //To catch errors that happen outside of the Flutter context, install an error listener on the current Isolate:
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        fatal: true,
        printDetails: true,
        reason: "Error that happened outside of the Flutter context",
        errorAndStacktrace.last,
      );
    }).sendPort);
    runApp(await getApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

void printScreenInformation() {
  if (kDebugMode) {
    print('Device type:${DeviceUtils.getDeviceType().toString()}');
    print('Device Size:${Size(1.sw, 1.sh)}');
    print('Device pixel density:${ScreenUtil().pixelRatio}');
    print('Bottom safe zone distance dp:${ScreenUtil().bottomBarHeight}dp');
    print('Status bar height dp:${ScreenUtil().statusBarHeight}dp');
    print('The ratio of actual width to UI design:${ScreenUtil().scaleWidth}');
    print(
        'The ratio of actual height to UI design:${ScreenUtil().scaleHeight}');
    print('System font scaling:${ScreenUtil().textScaleFactor}');
    print('0.5 times the screen width:${0.5.sw}dp');
    print('0.5 times the screen height:${0.5.sh}dp');
    print('Screen orientation:${ScreenUtil().orientation}');
  }
}

