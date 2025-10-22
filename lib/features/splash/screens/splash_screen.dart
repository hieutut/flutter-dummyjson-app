import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../product/screens/product_list_screen.dart';

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
        context.goNamed(ProductListScreen.routeName);
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
