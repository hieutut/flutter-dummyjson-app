// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_dummyjson_app/data/model/product/product.dart' as _i7;
import 'package:flutter_dummyjson_app/features/cart/screens/cart_screen.dart'
    as _i1;
import 'package:flutter_dummyjson_app/features/product/screens/product_detail_screen.dart'
    as _i2;
import 'package:flutter_dummyjson_app/features/product/screens/product_list_screen.dart'
    as _i3;
import 'package:flutter_dummyjson_app/features/splash/screens/splash_screen.dart'
    as _i4;

/// generated route for
/// [_i1.CartScreen]
class CartRoute extends _i5.PageRouteInfo<void> {
  const CartRoute({List<_i5.PageRouteInfo>? children})
      : super(CartRoute.name, initialChildren: children);

  static const String name = 'CartRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.CartScreen();
    },
  );
}

/// generated route for
/// [_i2.ProductDetailScreen]
class ProductDetailRoute extends _i5.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i6.Key? key,
    _i7.Product? product,
    int? productId,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          ProductDetailRoute.name,
          args: ProductDetailRouteArgs(
            key: key,
            product: product,
            productId: productId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>(
        orElse: () => const ProductDetailRouteArgs(),
      );
      return _i5.WrappedRoute(
        child: _i2.ProductDetailScreen(
          key: args.key,
          product: args.product,
          productId: args.productId,
        ),
      );
    },
  );
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({this.key, this.product, this.productId});

  final _i6.Key? key;

  final _i7.Product? product;

  final int? productId;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, product: $product, productId: $productId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductDetailRouteArgs) return false;
    return key == other.key &&
        product == other.product &&
        productId == other.productId;
  }

  @override
  int get hashCode => key.hashCode ^ product.hashCode ^ productId.hashCode;
}

/// generated route for
/// [_i3.ProductListScreen]
class ProductListRoute extends _i5.PageRouteInfo<void> {
  const ProductListRoute({List<_i5.PageRouteInfo>? children})
      : super(ProductListRoute.name, initialChildren: children);

  static const String name = 'ProductListRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i3.ProductListScreen());
    },
  );
}

/// generated route for
/// [_i4.SplashScreen]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashScreen();
    },
  );
}
