import 'package:flutter/material.dart';

abstract class IRouteBuilder {
  final Widget Function(
    BuildContext context,
    Animation<double>? animation,
    Animation<double>? secondaryAnimation,
  ) create;
  Route<dynamic> generateRoute({required RouteSettings settings, bool? fullscreenDialog});

  IRouteBuilder({
    required this.create,
  });
}

class MaterialRouteBuilder extends IRouteBuilder {
  MaterialRouteBuilder({
    required super.create,
  });

  @override
  Route generateRoute({
    required RouteSettings settings,
    bool? fullscreenDialog,
  }) {
    return MaterialPageRoute(
      builder: (context) => create(context, null, null),
      settings: settings,
      fullscreenDialog: fullscreenDialog ?? false,
    );
  }
}

class NoTransitionRouteBuilder extends IRouteBuilder {
  NoTransitionRouteBuilder({
    required super.create,
  });

  bool get opaque => true;

  @override
  Route generateRoute({
    required RouteSettings settings,
    bool? fullscreenDialog,
  }) {
    return PageRouteBuilder(
      opaque: opaque,
      settings: settings,
      fullscreenDialog: fullscreenDialog ?? false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return create(context, animation, secondaryAnimation);
      },
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}

class CustomAnimatedRouteBuilder extends IRouteBuilder {
  CustomAnimatedRouteBuilder({
    required super.create,
  });

  @override
  Route generateRoute({
    required RouteSettings settings,
    bool? fullscreenDialog,
    RouteTransitionsBuilder? transitionBuilder,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder(
      settings: settings,
      fullscreenDialog: fullscreenDialog ?? false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return create(context, animation, secondaryAnimation);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (transitionBuilder != null) {
          return transitionBuilder(context, animation, secondaryAnimation, child);
        }
        return child;
      },
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
    );
  }
}
