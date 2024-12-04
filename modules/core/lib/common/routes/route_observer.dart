import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../logging/logging.dart';

class _AppRouteObserverConstants {
  static final blankRoute = MaterialPageRoute(
    builder: (context) => const SizedBox.shrink(),
    settings: const RouteSettings(name: '/'),
  );
}

class AppRouteObserver extends AutoRouterObserver {
  final List<Route<dynamic>> _routeStack = [_AppRouteObserverConstants.blankRoute];
  List<Route<dynamic>> get routeStack => _routeStack;

  late Route<dynamic> _currentRoute;
  late Route<dynamic> _lastRoute;

  Route<dynamic> get currentRoute => _currentRoute;
  Route<dynamic> get lastRoute => _lastRoute;

  static final AppRouteObserver _instance = AppRouteObserver._internal();
  static AppRouteObserver get instance => _instance;

  NavigatorState? get navigatorState => navigator;
  BuildContext? get context => navigatorState?.context;

  static bool logRouteStack = false;

  AppRouteObserver._internal() {
    _currentRoute = _AppRouteObserverConstants.blankRoute;
    _lastRoute = _AppRouteObserverConstants.blankRoute;
  }

  void _trackRoute(Route<dynamic>? currentRoute, Route<dynamic>? previousRoute, {required String direct}) {
    _currentRoute = currentRoute!;
    _lastRoute = previousRoute!;
    printOut('$direct ${_lastRoute.name} -> ${_currentRoute.name}', name: 'AppRouteObserver');
  }

  void _logRouteStack(String navigate) {
    if (!logRouteStack) return;
    final stack = routeStack.map((e) => e.name).toList();
    printOut('stack on $navigate: $stack', name: 'AppRouteObserver');
  }

  bool checkRouter(Route<dynamic>? route) {
    final routeRuntimeType = route.runtimeType.toString();
    return (route is PageRoute || routeRuntimeType.startsWith('_OpenContainerRoute'));
  }

  bool verifyRoutes(Route<dynamic>? currentRoute, Route<dynamic>? previousRoute) {
    return checkRouter(currentRoute) && checkRouter(previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (verifyRoutes(route, previousRoute)) {
      _trackRoute(route, previousRoute, direct: 'didPush');
      _routeStack.add(route);
      _logRouteStack("didPush");
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (verifyRoutes(route, previousRoute)) {
      _trackRoute(previousRoute, route, direct: 'didPop');
      if (_routeStack.isNotEmpty) _routeStack.removeLast();
      _logRouteStack("didPop");
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (checkRouter(route)) {
      final int indexRouteRemove = _routeStack.lastIndexWhere((e) => e.name == route.name);
      if (indexRouteRemove != -1) _routeStack.removeAt(indexRouteRemove);
      _logRouteStack("didRemove");
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (verifyRoutes(newRoute, oldRoute)) {
      _trackRoute(newRoute, oldRoute, direct: 'didReplace');
      final int indexRouteReplace = _routeStack.lastIndexWhere((e) => e.name == oldRoute!.name);
      if (indexRouteReplace != -1) _routeStack[indexRouteReplace] = newRoute!;
      _logRouteStack("didReplace");
    }

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

extension RouteExt on Route {
  String get name => settings.name ?? '';
  Object? get arguments => settings.arguments;
}
