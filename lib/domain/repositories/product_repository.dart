import '../../data/model/product/product.dart';
import '../../data/model/request/request_param.dart';
import '../../data/model/response/list_product_response.dart';

abstract class ProductRepository {
  Future<ListProductResponse> getProductList({RequestParam? param});
  Future<Product> getProductById(int id);
}
