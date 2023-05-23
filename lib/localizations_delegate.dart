import 'package:flutter/material.dart';
import 'generated/locale_base.dart';

class LocDelegate extends LocalizationsDelegate<LocaleBase> {
  LocDelegate();
  final idMap = const {'en': 'locales/EN_US.json', 'ar': 'locales/AR_EU.json'};
  late final LocaleBase locBase = LocaleBase();
  Localemain get main => locBase.main;
  late String lang;
  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<LocaleBase> load(Locale locale) async {
    lang = 'ar';
    if (isSupported(locale)) lang = locale.languageCode;
    await locBase.load(idMap[lang]!);
    return locBase;
  }

  @override
  bool shouldReload(LocDelegate old) => false;
}
