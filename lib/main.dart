import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/config/config.dart';
import 'common/config/environment.dart';
import 'dependency_injection/di.dart';
import 'features/settings/theme/cubit/theme_cubit.dart';
import 'routes/app_router.dart';
import 'styles/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = CubitBaseObserver();
  Config.setEnv(Environment.PROD);
  await initDependencies();
  AppRouteObserver.logRouteStack = true;
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

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
            builder: (context, child) {
              ScreenUtil.instance.setup(context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
                child: child!,
              );
            },
            // routerDelegate: _appRouter.delegate(
            //   navigatorObservers: () => [
            //     AppRouteObserver.instance,
            //     AutoRouteObserver(),
            //   ],
            // ),
            routerConfig: _appRouter.config(
              navigatorObservers: () => [
                AppRouteObserver.instance,
                AutoRouteObserver(),
              ],
            ),
            // onGenerateRoute: Routes.generateRoute,
            // initialRoute: SplashScreen.routeName,
          );
        },
      ),
    );
  }
}
