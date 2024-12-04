import 'dart:io';

import 'package:dio/dio.dart';

import '../../error/error.dart';
import '../model/error_response.dart';

class BaseInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // var token = '';
    // final accessToken = tokenAdapter.accessToken;
    // final authCode = tokenAdapter.authCode;

    // if (accessToken?.isNotEmpty == true) {
    //   token = 'Bearer $accessToken';
    // } else {
    //   if (authCode?.isNotEmpty == true) {
    //     token = 'Bearer $authCode';
    //   }
    // }
    // if (token.isNotEmpty == true) {
    //   options.headers['Authorization'] = token;
    // }
    // if (interceptorAdapter.languageCode != null) {
    //   options.headers['Accept-Language'] = interceptorAdapter.languageCode;
    // }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode ?? 0;
    if (statusCode < 200 || statusCode > 300) {
      if (response.data is Map) {
        final errorRaw = response.data['error'];
        if (errorRaw != null) {
          final error = ErrorResponse.fromJson(errorRaw);
          handler.reject(
            ApiException(
              requestOptions: response.requestOptions,
              code: error.code,
              message: error.message ?? '',
              description: error.description,
              statusCode: statusCode,
              response: response,
            ),
          );
          return;
        }
      }
      handler.reject(
        ApiException(
          requestOptions: response.requestOptions,
          description: response.data.toString(),
          statusCode: statusCode,
        ),
      );
      return;
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final bool isTimeout = [
      DioExceptionType.connectionTimeout,
      DioExceptionType.sendTimeout,
      DioExceptionType.receiveTimeout,
    ].contains(err.type);
    if (isTimeout || err.error is SocketException || err.error is HttpException) {
      handler.reject(
        ApiException(
          requestOptions: err.requestOptions,
          code: isTimeout ? ErrorCode.TIMEOUT : ErrorCode.CONNECTION_ERROR,
          message: isTimeout ? ErrorCode.TIMEOUT : ErrorCode.CONNECTION_ERROR,
          statusCode: err.response?.statusCode,
          originError: err.error,
          error: err.error,
          response: err.response,
          type: err.type,
          stackTrace: err.stackTrace,
        ),
      );
      return;
    }
    handler.reject(
      ApiException(
        requestOptions: err.requestOptions,
        message: err.message ?? '',
        statusCode: err.response?.statusCode,
        originError: err.error,
        error: err.error,
        response: err.response,
        type: err.type,
        stackTrace: err.stackTrace,
      ),
    );
  }
}
