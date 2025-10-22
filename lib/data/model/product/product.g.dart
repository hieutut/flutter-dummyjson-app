// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      brand: json['brand'] as String?,
      sku: json['sku'] as String,
      weight: (json['weight'] as num?)?.toInt() ?? 0,
      dimensions: json['dimensions'] == null
          ? null
          : ProductDimensions.fromJson(
              json['dimensions'] as Map<String, dynamic>),
      warrantyInformation: json['warrantyInformation'] as String?,
      shippingInformation: json['shippingInformation'] as String?,
      availabilityStatus: json['availabilityStatus'] as String?,
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      returnPolicy: json['returnPolicy'] as String?,
      minimumOrderQuantity:
          (json['minimumOrderQuantity'] as num?)?.toInt() ?? 1,
      meta: json['meta'] == null
          ? null
          : ProductMeta.fromJson(json['meta'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'discountPercentage': instance.discountPercentage,
      'rating': instance.rating,
      'stock': instance.stock,
      'tags': instance.tags,
      if (instance.brand case final value?) 'brand': value,
      'sku': instance.sku,
      'weight': instance.weight,
      if (instance.dimensions?.toJson() case final value?) 'dimensions': value,
      if (instance.warrantyInformation case final value?)
        'warrantyInformation': value,
      if (instance.shippingInformation case final value?)
        'shippingInformation': value,
      if (instance.availabilityStatus case final value?)
        'availabilityStatus': value,
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
      if (instance.returnPolicy case final value?) 'returnPolicy': value,
      'minimumOrderQuantity': instance.minimumOrderQuantity,
      if (instance.meta?.toJson() case final value?) 'meta': value,
      'images': instance.images,
      if (instance.thumbnail case final value?) 'thumbnail': value,
    };
