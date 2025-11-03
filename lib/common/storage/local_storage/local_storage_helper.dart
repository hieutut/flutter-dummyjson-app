import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton()
class LocalStorageHelper {
  @FactoryMethod(preResolve: true)
  static Future<LocalStorageHelper> init() async {
    final helper = LocalStorageHelper()
      .._prefs = await SharedPreferencesWithCache.create(
        cacheOptions: SharedPreferencesWithCacheOptions(),
      );
    return helper;
  }

  late final SharedPreferencesWithCache _prefs;

  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);
  bool? getBool(String key) => _prefs.getBool(key);
  Future<bool?> getBoolAsync(String key) async {
    await reloadCache();
    return _prefs.getBool(key);
  }

  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);
  int? getInt(String key) => _prefs.getInt(key);
  Future<int?> getIntAsync(String key) async {
    await reloadCache();
    return _prefs.getInt(key);
  }

  Future<void> setDouble(String key, double value) => _prefs.setDouble(key, value);
  double? getDouble(String key) => _prefs.getDouble(key);
  Future<double?> getDoubleAsync(String key) async {
    await reloadCache();
    return _prefs.getDouble(key);
  }

  Future<void> setString(String key, String value) => _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);
  Future<String?> getStringAsync(String key) async {
    await reloadCache();
    return _prefs.getString(key);
  }

  Future<void> setStringList(String key, List<String> value) => _prefs.setStringList(key, value);
  List<String>? getStringList(String key) => _prefs.getStringList(key);
  Future<List<String>?> getStringListAsync(String key) async {
    await reloadCache();
    return _prefs.getStringList(key);
  }

  bool containsKey(String key) => _prefs.containsKey(key);

  Future<void> remove(String key) => _prefs.remove(key);

  Future<void> clear() => _prefs.clear();

  Future<void> reloadCache() => _prefs.reloadCache();
}
