import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../config/config.dart';
import '../config/environment.dart';

@Injectable()
class Api extends BaseApi {
  Api({
    super.timeout,
    super.connectTimeout,
    super.sendTimeout,
    super.receiveTimeout,
    super.debugMode,
  }) : super(
          baseUrl: Config.env.baseUrl,
          clientKey: Config.env.clientKey,
          secretKey: Config.env.secretKey,
        );

  @factoryMethod
  factory Api.create() => Api(debugMode: false);
}
