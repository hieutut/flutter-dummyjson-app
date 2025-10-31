import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../common/dependency_injection/di.dart';
import '../../../../common/networking/networking.dart';
import '../../../model/product/product.dart';
import '../../../model/request/request_param.dart';
import '../../../model/response/list_product_response.dart';
import '../api_endpoint.dart';

part 'product_client.g.dart';

@Injectable()
@RestApi()
abstract class ProductClient {
  factory ProductClient(Dio dio, {String baseUrl}) = _ProductClient;

  @factoryMethod
  factory ProductClient.create() => ProductClient(getIt<Api>().dio);

  @GET(ApiEndpoint.products)
  Future<ListProductResponse> getProductList({@Queries() RequestParam? param = const RequestParam()});

  @GET('${ApiEndpoint.products}/{id}')
  Future<Product> getProductById(@Path('id') int id);
}
