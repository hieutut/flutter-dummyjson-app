import 'dart:convert';

class JsonUtil {
  /// Encode `data` thành dạng String.
  ///
  /// Nếu bị lỗi format không encode được thì return null.
  static String? tryEncode(Object? data) {
    try {
      return jsonEncode(data);
    } catch (e) {
      return null;
    }
  }

  /// Decode string `data` thành dạng json.
  ///
  /// Nếu bị lỗi format không decode được thì return null.
  static dynamic tryDecode(String data) {
    try {
      return jsonDecode(data);
    } catch (e) {
      return null;
    }
  }
}
