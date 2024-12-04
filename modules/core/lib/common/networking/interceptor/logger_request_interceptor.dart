import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utility/json_util.dart';
import '../utility/pretty_json_string.dart';

class LoggerRequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
      prettyJsonStr({
        'from': 'onRequest',
        'Time': DateTime.now().toString(),
        'baseUrl': options.baseUrl,
        'path': options.path,
        'headers': options.headers,
        'method': options.method,
        'requestData': options.data is FormData ? (options.data as FormData).toMap() : options.data,
        'queryParameters': options.queryParameters,
      }),
    );
    super.onRequest(options, handler);
  }
}

extension FormDataExt on FormData {
  Map<String, dynamic> toMap() {
    return {
      'files': files.map((e) => e.value.filename).toList(),
      'fields': Map.fromEntries(
        fields
            .map(
              (e) => MapEntry(
                e.key,
                JsonUtil.tryDecode(e.value) ?? e.value,
              ),
            )
            .toList(),
      ),
    };
  }
}
