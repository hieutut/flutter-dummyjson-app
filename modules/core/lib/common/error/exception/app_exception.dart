import '../error_code.dart';

class AppException implements Exception {
  final String code;
  final String message;
  final String? description;
  final dynamic originError;

  AppException({
    required String code,
    this.message = '',
    this.description,
    this.originError,
  }) : code = code.isNotEmpty ? code : ErrorCode.UNKNOWN;

  String get messageWithCode {
    return '[$code] $message';
  }

  String get messageFull {
    String msg = messageWithCode;
    if (description?.isNotEmpty == true) msg = '$msg\n($description)';
    return msg;
  }

  @override
  String toString() {
    return '$runtimeType(code: $code, message: $message, description: $description, originError: $originError)';
  }
}
