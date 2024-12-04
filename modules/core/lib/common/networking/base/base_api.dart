import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../interceptor/base_interceptor.dart';
import 'api_client.dart';

abstract class BaseApi {
  late final Dio _dio;
  late final bool _debugMode;

  Dio get dio => _dio;

  BaseApi({
    required String baseUrl,
    required String clientKey,
    String? secretKey,
    int? timeout,
    int? connectTimeout,
    int? sendTimeout,
    int? receiveTimeout,
    bool? debugMode,
  }) {
    _debugMode = debugMode ?? kDebugMode;
    _dio = ApiClient.setup(
      baseUrl: baseUrl,
      clientKey: clientKey,
      timeout: timeout,
      connectTimeout: connectTimeout,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
    );
    _dio.interceptors.addAll([
      if (_debugMode) PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 120,
      ),
      // if (_debugMode) LoggerResponseInterceptor(),
      BaseInterceptor(),
      // if (_debugMode) LoggerRequestInterceptor(),
    ]);
  }
}
