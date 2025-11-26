// class LocalStorageKey {
//   LocalStorageKey._();

//   static const String token = 'token';
// }

import '../../../../common/dependency_injection/di.dart';
import 'local_storage_helper.dart';

class LocalStorageKey<T> {
  final String key;

  const LocalStorageKey._({required this.key});

  static const LocalStorageKey<String> token = LocalStorageKey<String>._(key: 'token');
  static const LocalStorageKey<List<String>> keywords = LocalStorageKey<List<String>>._(key: 'keywords');
}

extension LocalStorageKeyExt<T> on LocalStorageKey<T> {
  LocalStorageHelper get _helper => getIt<LocalStorageHelper>();

  bool isExisted() => _helper.containsKey(key);

  Future<void> remove() => _helper.remove(key);

  Future<void> set(T value) {
    return switch (T) {
      const (bool) => _helper.setBool(key, value as bool),
      const (int) => _helper.setInt(key, value as int),
      const (double) => _helper.setDouble(key, value as double),
      const (String) => _helper.setString(key, value as String),
      const (List<String>) => _helper.setStringList(key, value as List<String>),
      _ => throw Exception('Type not supported'),
    };
  }

  T? get() {
    return switch (T) {
      const (bool) => _helper.getBool(key),
      const (int) => _helper.getInt(key),
      const (double) => _helper.getDouble(key),
      const (String) => _helper.getString(key),
      const (List<String>) => _helper.getStringList(key),
      _ => throw Exception('Type not supported'),
    } as T?;
  }

  Future<T?> getAsync() async {
    return (await switch (T) {
      const (bool) => _helper.getBoolAsync(key),
      const (int) => _helper.getIntAsync(key),
      const (double) => _helper.getDoubleAsync(key),
      const (String) => _helper.getStringAsync(key),
      const (List<String>) => _helper.getStringListAsync(key),
      _ => throw Exception('Type not supported'),
    }) as T?;
  }
}
