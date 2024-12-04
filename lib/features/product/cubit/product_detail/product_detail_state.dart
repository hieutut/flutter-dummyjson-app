// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_detail_cubit.dart';

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.product = Product.empty,
    this.getProductsState = DataState.init,
    this.error,
  });

  final Product product;
  final DataState getProductsState;
  final AppException? error;

  ProductDetailState copyWith({
    Product? product,
    DataState? getProductsState,
    AppException? error,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      getProductsState: getProductsState ?? this.getProductsState,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        product,
        getProductsState,
        error,
      ];
}
