import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../common/routes/routes.dart';

export 'package:auto_route/auto_route.dart';

abstract class LifecycleStatefulWidgetState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver, AutoRouteAwareStateMixin<T> {
  AppRouteObserver get routeObserver => AppRouteObserver.instance;
  StackRouter get router => context.router;

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
      ..addObserver(this)
      ..addPostFrameCallback((_) {
        // onPostFrameCallback();
        onViewCreated();
      });
  }

  // @mustCallSuper
  // void onPostFrameCallback() {
  //   if (mounted && ModalRoute.of(context) is PageRoute) {
  //     onPostFrameCallbackForPageRoute();
  //   }
  // }

  // @mustCallSuper
  // void onPostFrameCallbackForPageRoute() {
  //   routeObserver.subscribe(
  //     this,
  //     ModalRoute.of(context) as PageRoute,
  //   );
  // }

  @mustCallSuper
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // routeObserver.unsubscribe(this);
    super.dispose();
  }

  void onViewCreated() {}

  void onResumed() {}
  void onPaused() {}
  void onDetached() {}
  void onInactive() {}
  void onHidden() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.hidden:
        onHidden();
        break;
    }
  }
}
