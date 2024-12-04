// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dimensions.g.dart';

@JsonSerializable()
class ProductDimensions extends Equatable {
  final double width;
  final double height;
  final double depth;

  ProductDimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) => _$ProductDimensionsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDimensionsToJson(this);

  ProductDimensions copyWith({
    double? width,
    double? height,
    double? depth,
  }) {
    return ProductDimensions(
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
    );
  }

  @override
  List<Object?> get props => [
        width,
        height,
        depth,
      ];
}
