import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'common/config/config.dart';
import 'common/config/environment.dart';
import 'common/constants/assets.gen.dart';
import 'common/dependency_injection/di.dart';
import 'features/settings/language/app_language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Config.setEnv(Environment.PROD);

  await initDependencies();

  AppRouteObserver.logRouteStack = true;

  runApp(
    EasyLocalization(
      supportedLocales: AppLanguage.supportedLocales,
      saveLocale: true,
      startLocale: AppLanguage.defaultLocale,
      fallbackLocale: AppLanguage.defaultLocale,
      path: Assets.dummyjson_app_localization_csv,
      assetLoader: CsvAssetLoader(),
      child: MainApp(),
    ),
  );
}
