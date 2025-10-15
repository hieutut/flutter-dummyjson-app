import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/config/config.dart';
import 'common/config/environment.dart';
import 'dependency_injection/di.dart';
import 'routes/app_router.dart';

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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp.router(
        title: 'DummyJson App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: (context, child) {
          ScreenUtil.instance.setup(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
            child: child!,
          );
        },
        routerConfig: _appRouter.config(
          navigatorObservers: () {
            return [
              AppRouteObserver.instance,
              AutoRouteObserver(),
            ];
          },
        ),
        // onGenerateRoute: Routes.generateRoute,
        // initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
