import 'package:flutter_dummyjson_app/common/dependency_injection/di.dart';
import 'package:flutter_dummyjson_app/data/datasource/local/shared_preferences/local_storage_key.dart';
import 'package:flutter_test/flutter_test.dart';

// Tạm thời đang lỗi test
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  group(
    'Test LocalStorageKey',
    () {
      test(
        'Test set / get value',
        () async {
          await LocalStorageKey.token.set('Bearer 12345678');

          expect(LocalStorageKey.token.isExisted(), true);
        },
      );
    },
  );
}
