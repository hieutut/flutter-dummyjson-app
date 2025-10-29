import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/localization/localization.gen.dart';

class AppLanguage {
  AppLanguage._();

  static bool _didInitLanguage = false;

  static Future<void> init(BuildContext context) async {
    if (_didInitLanguage) return;
    _didInitLanguage = true;
    if (context.savedLocale == null) {
      final Locale initLocale = AppLanguage.supportedLocales.firstWhere(
            (e) => e == context.deviceLocale,
            orElse: () => AppLanguage.defaultLocale,
          );
      await context.setLocale(initLocale);
    }
  }

  static Future<void> setLocale(BuildContext context, Locale locale) {
    return context.setLocale(locale);
  }

  static List<Locale> get supportedLocales => L.LANGUAGES.map((e) => e.toLocale()).toList();

  static Locale get defaultLocale => L.LANGUAGE_DEFAULT.toLocale();
}
