// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_list_cubit.dart';

class ProductListState extends Equatable {
  const ProductListState({
    this.getProductsState = DataState.init,
    this.products = const [],
    this.currentQuery = RequestParam.FIRST_PAGE,
    this.error,
  });

  final DataState getProductsState;
  final List<Product> products;
  final RequestParam currentQuery;
  final AppException? error;

  ProductListState copyWith({
    DataState? getProductsState,
    List<Product>? products,
    RequestParam? currentQuery,
    AppException? error,
  }) {
    return ProductListState(
      getProductsState: getProductsState ?? this.getProductsState,
      products: products ?? this.products,
      currentQuery: currentQuery ?? this.currentQuery,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        getProductsState,
        products,
        currentQuery,
        error,
      ];
}
