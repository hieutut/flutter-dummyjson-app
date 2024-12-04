import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/metric_constants.dart';
import '../../../dependency_injection/di.dart';
import '../../../routes/app_router.dart';
import '../cubit/product_list/product_list_cubit.dart';
import '../widgets/product_item_widget.dart';

@RoutePage()
class ProductListScreen extends StatefulWidget implements AutoRouteWrapper {
  const ProductListScreen({super.key});

  static const String routeName = '/product-list';

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ProductListCubit>(
      create: (context) => getIt<ProductListCubit>(),
      child: this,
    );
  }
}

class _ProductListScreenState extends BaseStatefulWidgetState<ProductListScreen> {
  late final ProductListCubit productListCubit = context.read();

  @override
  void onViewCreated() {
    super.onViewCreated();
    productListCubit.getListProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            onPressed: () {
              router.push(const CartRoute());
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: kIconSize24,
            ),
          ),
          kBoxSpace8,
        ],
      ),
      body: Center(
        child: BlocBuilder<ProductListCubit, ProductListState>(
          buildWhen: (previous, current) {
            return previous.getProductsState != current.getProductsState ||
                !listEquals(previous.products, current.products);
          },
          builder: (context, state) {
            if (state.getProductsState.isInitOrLoading) {
              return const CircularProgressIndicator();
            }
            return RefreshableWidget(
              refreshController: productListCubit.refreshController,
              onRefresh: productListCubit.getListProducts,
              onLoadMore: productListCubit.loadMoreProducts,
              builder: (context) {
                return ListView.separated(
                  itemCount: state.products.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
                  itemBuilder: (context, index) {
                    return ProductItemWidget(product: state.products[index]);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
