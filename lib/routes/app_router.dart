import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/model/product/product.dart';
import '../dependency_injection/di.dart';
import '../features/cart/screens/cart_screen.dart';
import '../features/product/cubit/product_detail/product_detail_cubit.dart';
import '../features/product/cubit/product_list/product_list_cubit.dart';
import '../features/product/screens/product_detail_screen.dart';
import '../features/product/screens/product_list_screen.dart';
import '../features/splash/screens/splash_screen.dart';

class AppRouter {
  static final GoRouter config = GoRouter(
    navigatorKey: NavigationService.navigationKey,
    observers: [
      AppRouteObserver.instance,
    ],
    initialLocation: SplashScreen.routeName,
    routes: [
      _route(
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      _route(
        name: ProductListScreen.routeName,
        builder: (context, state) => BlocProvider<ProductListCubit>(
          create: (context) => getIt<ProductListCubit>(),
          child: const ProductListScreen(),
        ),
      ),
      _route(
        path: ProductDetailScreen.routePath,
        name: ProductDetailScreen.routeName,
        builder: (context, state) => BlocProvider<ProductDetailCubit>(
          create: (context) => getIt<ProductDetailCubit>(),
          child: ProductDetailScreen(
            product: state.extra is Product ? state.extra as Product : null,
            productId: int.tryParse(state.pathParameters[ProductDetailScreen.pathParam] ?? ''),
          ),
        ),
      ),
      _route(
        name: CartScreen.routeName,
        builder: (context, state) => const CartScreen(),
      ),
    ],
  );

  static RouteBase _route({
    required String name,
    String? path,
    GoRouterWidgetBuilder? builder,
    GoRouterPageBuilder? pageBuilder,
  }) {
    return GoRoute(
      name: name,
      path: path ?? name,
      builder: builder,
      pageBuilder: pageBuilder,
    );
  }
}
