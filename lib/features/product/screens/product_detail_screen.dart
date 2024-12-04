// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/metric_constants.dart';
import '../../../common/ui/app_loading.dart';
import '../../../data/model/product/product.dart';
import '../../../dependency_injection/di.dart';
import '../cubit/product_detail/product_detail_cubit.dart';
import '../widgets/product_images_widget.dart';

@RoutePage()
class ProductDetailScreen extends StatefulWidget implements AutoRouteWrapper {
  final Product? product;
  final int? productId;

  const ProductDetailScreen({
    super.key,
    this.product,
    this.productId,
  });

  static const String routeName = '/product-detail';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductDetailCubit>(),
      child: this,
    );
  }
}

class _ProductDetailScreenState extends BaseStatefulWidgetState<ProductDetailScreen> {
  late final ProductDetailCubit productDetailCubit = context.read();

  @override
  void onViewCreated() {
    super.onViewCreated();
    if (widget.product != null) {
      productDetailCubit.setProduct(widget.product!);
    } else if (widget.productId != null) {
      productDetailCubit.getProductById(widget.productId!);
    } else {
      context.showMessageError("Can't get product detail");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        buildWhen: (previous, current) {
          return current.getProductsState.isSuccess;
        },
        builder: (context, state) {
          if (state.getProductsState.isInitOrLoading) {
            return const AppLoading();
          } else if (state.getProductsState.isError) {
            return kBoxEmpty;
          }

          final product = state.product;
          return DisableScrollViewStretchingEffect(
            child: RefreshableWidget(
              refreshController: productDetailCubit.refreshController,
              onRefresh: () => productDetailCubit.getProductById(product.id),
              builder: (context) {
                return ListView(
                  children: [
                    if (product.images.isNotEmpty) ProductImagesWidget(images: product.images),
                    Padding(
                      padding: kPaddingDefaultHor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            product.title,
                            style: theme.textTheme.titleLarge,
                          ),
                          kBoxSpaceItem,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Stock: ${product.stock}',
                                style: theme.textTheme.titleSmall,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: '\$${product.discountPriceString}',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: Colors.redAccent.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    if (product.hasDiscount) ...[
                                      const TextSpan(text: ' '),
                                      TextSpan(
                                        text: '\$${product.price}',
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                          kBoxSpaceItem,
                          Text(
                            product.description,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
