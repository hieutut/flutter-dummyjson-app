// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_meta.g.dart';

@JsonSerializable()
class ProductMeta extends Equatable {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? barcode;
  final String? qrCode;

  const ProductMeta({
    required this.createdAt,
    required this.updatedAt,
    this.barcode,
    this.qrCode,
  });

  factory ProductMeta.fromJson(Map<String, dynamic> json) => _$ProductMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMetaToJson(this);

  ProductMeta copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? barcode,
    String? qrCode,
  }) {
    return ProductMeta(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      barcode: barcode ?? this.barcode,
      qrCode: qrCode ?? this.qrCode,
    );
  }

  @override
  List<Object?> get props => [
        createdAt,
        updatedAt,
        barcode,
        qrCode,
      ];
}
