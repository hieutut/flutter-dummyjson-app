// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/metric_constants.dart';
import '../../../common/ui/app_loading.dart';
import '../../../data/model/product/product.dart';
import '../../../styles/app_theme.dart';
import '../cubit/product_detail/product_detail_cubit.dart';
import '../widgets/product_images_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product? product;
  final int? productId;

  const ProductDetailScreen({
    super.key,
    this.product,
    this.productId,
  });

  static const String routeName = '/product-detail';

  static const String pathParam = 'productId';

  static const String routePath = '$routeName/:$pathParam';

  static String routeWithPath(int productId) => routePath.replaceFirst(':$pathParam', '$productId');

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
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
                            style: context.text.title3.medium,
                          ),
                          kBoxSpaceItem,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Stock: ${product.stock}',
                                style: context.text.callout.medium,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: '\$${product.discountPriceString}',
                                  style: context.text.callout.copyWith(
                                    color: Colors.redAccent.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    if (product.hasDiscount) ...[
                                      const TextSpan(text: ' '),
                                      TextSpan(
                                        text: '\$${product.price}',
                                        style: context.text.footnote.copyWith(
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
                            style: context.text.callout,
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
