import 'package:flutter/material.dart';

import '../../common/routes/route_observer.dart';

mixin StateCommonMixin<T extends StatefulWidget> on State<T> {
  AppRouteObserver get routeObserver => AppRouteObserver.instance;
}
