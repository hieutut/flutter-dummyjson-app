import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utility/pretty_json_string.dart';

class LoggerResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      prettyJsonStr({
        'from': 'onResponse',
        'Time': DateTime.now().toString(),
        'statusCode': response.statusCode,
        'baseUrl': response.requestOptions.baseUrl,
        'path': response.requestOptions.path,
        'method': response.requestOptions.method,
        'responseData': response.data,
      }),
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    debugPrint(
      prettyJsonStr({
        'from': 'onError',
        'Time': DateTime.now().toString(),
        'baseUrl': error.requestOptions.baseUrl,
        'header': error.requestOptions.headers,
        'path': error.requestOptions.path,
        'type': error.type,
        'message': error.message,
        'statusCode': error.response?.statusCode,
        'error': error.error,
        'responseData': error.requestOptions.data,
      }),
    );
    super.onError(error, handler);
  }
}
