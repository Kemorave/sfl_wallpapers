// ignore_for_file: non_constant_identifier_names

import 'package:sfl/generated/locale_base.dart';
import 'package:flutter/widgets.dart';
import 'package:sfl/locator.dart';
import 'package:get/get.dart';

import '../../../localizations_delegate.dart';

class LanguageCodes {
  static const arabicCode = 'ar';
  static const englishCode = 'en';
}

class LocalizationService extends GetxService {
  final _locale_st_key = "_local_st_key";
  final defaultLocale = const Locale(LanguageCodes.arabicCode);
  final locale = LocDelegate();
  Localemain get strings => locale.main;
  Future loadLocale() async {
    await locale.load(Locale(getCurrentLocal()));
  }

  String getCurrentLocal() =>
      localStorage().getKey(_locale_st_key) ?? defaultLocale.languageCode;
  bool isCurrentLanguageEnglish() =>
      getCurrentLocal() == LanguageCodes.englishCode;
  Future<void> setCurrentLocal(String loc) async {
    await localStorage().setKey(_locale_st_key, loc);
    await locale.load(Locale(loc));
  }
}
