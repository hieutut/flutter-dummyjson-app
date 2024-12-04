import 'package:dio/dio.dart';

class ApiClient {
  static const int TIMEOUT_DEFAULT = 30000;

  static Dio setup({
    required String baseUrl,
    required String clientKey,
    int? timeout,
    int? connectTimeout,
    int? sendTimeout,
    int? receiveTimeout,
  }) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      validateStatus: (status) {
        return true;
      },
      headers: {
        'Content-Type': 'application/json',
        'Client-Key': clientKey,
      },
      connectTimeout: Duration(milliseconds: connectTimeout ?? timeout ?? TIMEOUT_DEFAULT),
      sendTimeout: Duration(milliseconds: sendTimeout ?? timeout ?? TIMEOUT_DEFAULT),
      receiveTimeout: Duration(milliseconds: receiveTimeout ?? timeout ?? TIMEOUT_DEFAULT),
    );

    return Dio(options);
  }
}
