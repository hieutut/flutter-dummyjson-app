// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListProductResponse _$ListProductResponseFromJson(Map<String, dynamic> json) =>
    ListProductResponse(
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      skip: (json['skip'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ListProductResponseToJson(ListProductResponse instance) {
  final val = <String, dynamic>{
    'products': instance.products.map((e) => e.toJson()).toList(),
    'total': instance.total,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('skip', instance.skip);
  writeNotNull('limit', instance.limit);
  return val;
}
