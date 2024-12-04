import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/data_state/data_state.dart';
import '../../../../data/model/product/product.dart';
import '../../../../data/model/request/request_param.dart';
import '../../../../domain/repositories/product_repository.dart';

part 'product_list_state.dart';

@injectable
class ProductListCubit extends CubitBase<ProductListState> with PullToRefreshCubitMixin {
  final ProductRepository repository;

  ProductListCubit({required this.repository}) : super(const ProductListState());

  void getListProducts({bool showLoading = true}) {
    runAction(
      () async {
        const query = RequestParam.FIRST_PAGE;
        emit(
          state.copyWith(
            getProductsState: showLoading ? DataState.loading : null,
            currentQuery: query,
          ),
        );
        final res = await repository.getProductList(param: query);
        emit(
          state.copyWith(
            getProductsState: DataState.success,
            products: res.products,
            currentQuery: query,
          ),
        );
      },
      onError: (error) {
        emit(state.copyWith(getProductsState: DataState.error, error: error));
      },
      onFinally: () => loadCompleted(),
    );
  }

  void loadMoreProducts() {
    runAction(
      () async {
        final query = state.currentQuery.nextPage();
        final res = await repository.getProductList(param: query);
        emit(
          state.copyWith(
            getProductsState: DataState.success,
            products: [...state.products, ...res.products],
            currentQuery: query,
          ),
        );
      },
      onError: (error) {
        emit(state.copyWith(getProductsState: DataState.error, error: error));
      },
      onFinally: () => loadCompleted(),
    );
  }
}
