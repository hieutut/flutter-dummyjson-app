import 'package:drift/drift.dart';

import '../converters/product_converter.dart';

class CartItemTable extends Table {
  late final IntColumn id = integer().autoIncrement()();
  late final TextColumn product = text().map(const ProductConverter())();
  late final IntColumn quantity = integer()
      .check(quantity.isBiggerOrEqual(const Constant(1)))
      .withDefault(const Constant(1))();
}
