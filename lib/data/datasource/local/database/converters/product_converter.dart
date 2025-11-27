import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../model/product/product.dart';

class ProductConverter extends TypeConverter<Product, String>
    with JsonTypeConverter2<Product, String, Map<String, Object?>> {
  const ProductConverter();

  @override
  Product fromSql(String fromDb) {
    return fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(Product value) {
    return json.encode(toJson(value));
  }

  @override
  Product fromJson(Map<String, Object?> json) {
    return Product.fromJson(json);
  }

  @override
  Map<String, Object?> toJson(Product value) {
    return value.toJson();
  }
}
