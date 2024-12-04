import 'package:auto_route/auto_route.dart';
import '../features/cart/screens/cart_screen.dart';
import '../features/product/screens/product_detail_screen.dart';
import '../features/product/screens/product_list_screen.dart';
import '../features/splash/screens/splash_screen.dart';
import 'app_router.gr.dart';

export 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        path: SplashScreen.routeName,
        page: SplashRoute.page,
        initial: true,
      ),
      AutoRoute(
        path: ProductListScreen.routeName,
        page: ProductListRoute.page,
      ),
      AutoRoute(
        path: ProductDetailScreen.routeName,
        page: ProductDetailRoute.page,
      ),
      AutoRoute(
        path: CartScreen.routeName,
        page: CartRoute.page,
      ),
    ];
  }
}
