// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';

import '../../domain/repositories/product_repository.dart';
import '../datasource/remote/client/product_client.dart';
import '../model/product/product.dart';
import '../model/request/request_param.dart';
import '../model/response/list_product_response.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductClient client;

  ProductRepositoryImpl({required this.client});

  @override
  Future<Product> getProductById(int id) async {
    final response = await client.getProductById(id);
    return response;
  }

  @override
  Future<ListProductResponse> getProductList({RequestParam? param = const RequestParam()}) async {
    final response = await client.getProductList(param: param);
    return response;
  }
}
