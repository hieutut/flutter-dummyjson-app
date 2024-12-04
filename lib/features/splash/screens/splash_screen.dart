import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_router.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseStatefulWidgetState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      500.milliseconds,
      () {
        if (!mounted) return;
        router.pushAndPopUntil(
          const ProductListRoute(),
          predicate: (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FlutterLogo(size: 100),
    );
  }
}
