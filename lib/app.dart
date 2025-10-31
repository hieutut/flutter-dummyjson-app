import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/dependency_injection/di.dart';
import 'common/routes/app_router.dart';
import 'common/ui/styles/app_theme.dart';
import 'features/settings/language/app_language.dart';
import 'features/settings/theme/cubit/theme_cubit.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  List<BlocProvider> get providers {
    return [
      BlocProvider<ConnectivityCubit>(
        create: (context) => getIt.get<ConnectivityCubit>(),
      ),
      BlocProvider<ThemeCubit>(
        create: (context) => getIt.get<ThemeCubit>(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    AppLanguage.init(context);
    return MultiBlocProvider(
      providers: providers,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        buildWhen: (previous, current) => previous.themeMode != current.themeMode,
        builder: (context, state) {
          return MaterialApp.router(
            title: 'DummyJson App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: (context, child) {
              ScreenUtil.instance.setup(context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
                child: child!,
              );
            },
            routerConfig: AppRouter.config,
          );
        },
      ),
    );
  }
}
