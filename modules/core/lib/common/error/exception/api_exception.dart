// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import '../error_code.dart';
import 'app_exception.dart';

class ApiException extends AppException implements DioException {
  ApiException({
    String? code,
    super.message,
    super.description,
    super.originError,
    this.statusCode = 200,
    required this.requestOptions,
    this.error,
    this.response,
    this.type = DioExceptionType.unknown,
    StackTrace? stackTrace,
  })  : stackTrace = stackTrace ?? StackTrace.current,
        super(code: code ?? ErrorCode.UNKNOWN);

  final int? statusCode;

  @override
  final Object? error;

  @override
  final RequestOptions requestOptions;

  @override
  final Response? response;

  @override
  final StackTrace stackTrace;

  @override
  final DioExceptionType type;

  @override
  DioException copyWith({
    String? code,
    String? message,
    String? description,
    dynamic originError,
    int? statusCode,
    Object? error,
    RequestOptions? requestOptions,
    Response? response,
    StackTrace? stackTrace,
    DioExceptionType? type,
  }) {
    return ApiException(
      code: code ?? this.code,
      message: message ?? this.message,
      description: description ?? this.description,
      originError: originError ?? this.originError,
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      requestOptions: requestOptions ?? this.requestOptions,
      response: response ?? this.response,
      stackTrace: stackTrace ?? this.stackTrace,
      type: type ?? this.type,
    );
  }
}
