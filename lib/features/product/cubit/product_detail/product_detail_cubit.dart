import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/data_state/data_state.dart';
import '../../../../data/model/product/product.dart';
import '../../../../domain/repositories/product_repository.dart';

part 'product_detail_state.dart';

@injectable
class ProductDetailCubit extends CubitBase<ProductDetailState> with PullToRefreshCubitMixin {
  final ProductRepository repository;

  ProductDetailCubit({required this.repository}) : super(const ProductDetailState());

  void getProductById(int id) async {
    return runAction(
      () async {
        emit(state.copyWith(getProductsState: DataState.loading));
        final res = await repository.getProductById(id);
        emit(
          state.copyWith(
            getProductsState: DataState.success,
            product: res,
          ),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            getProductsState: DataState.error,
            error: error,
          ),
        );
      },
      onFinally: () => loadCompleted(),
    );
  }

  void setProduct(Product product) {
    emit(
      state.copyWith(
        getProductsState: DataState.success,
        product: product,
      ),
    );
  }
}
