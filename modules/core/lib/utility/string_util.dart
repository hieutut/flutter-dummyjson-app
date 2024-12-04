extension StringExt on String {
  bool get isHttpUrl {
    return isNotEmpty && (toLowerCase().startsWith('http://') || toLowerCase().startsWith('https://'));
  }

  bool get isLocalPath {
    return isNotEmpty && (startsWith('/') || toLowerCase().startsWith('file://') || substring(1).startsWith(':\\'));
  }
}

extension NullableStringExt on String? {
  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;

  bool get isEmptyOrNull => this == null || this!.isEmpty;

  bool get isHttpUrl => this != null && this!.isHttpUrl;

  bool get isLocalPath => this != null && this!.isLocalPath;
}
