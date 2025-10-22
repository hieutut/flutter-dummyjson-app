// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductMeta _$ProductMetaFromJson(Map<String, dynamic> json) => ProductMeta(
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      barcode: json['barcode'] as String?,
      qrCode: json['qrCode'] as String?,
    );

Map<String, dynamic> _$ProductMetaToJson(ProductMeta instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      if (instance.barcode case final value?) 'barcode': value,
      if (instance.qrCode case final value?) 'qrCode': value,
    };
