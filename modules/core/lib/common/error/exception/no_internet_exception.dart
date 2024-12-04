import '../error_code.dart';
import 'app_exception.dart';

class NoInternetException extends AppException {
  NoInternetException({
    super.message,
    super.description,
    super.originError,
  }) : super(code: ErrorCode.CONNECTION_ERROR);
}
