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

Map<String, dynamic> _$ListProductResponseToJson(
  ListProductResponse instance,
) => <String, dynamic>{
  'products': instance.products.map((e) => e.toJson()).toList(),
  'total': instance.total,
  'skip': ?instance.skip,
  'limit': ?instance.limit,
};
