import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/metric_constants.dart';
import '../../../common/localization/localization.gen.dart';
import '../../cart/screens/cart_screen.dart';
import '../../settings/widgets/setting_drawer.dart';
import '../cubit/product_list/product_list_cubit.dart';
import '../widgets/product_item_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  static const String routeName = '/product-list';

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends BaseStatefulWidgetState<ProductListScreen> {
  late final ProductListCubit productListCubit = context.read();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onViewCreated() {
    super.onViewCreated();
    productListCubit.getListProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(context.tr(L.product_list)),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push(CartScreen.routeName);
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: kIconSize24,
            ),
          ),
          kBoxSpace8,
        ],
      ),
      drawer: const SettingDrawer(),
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
