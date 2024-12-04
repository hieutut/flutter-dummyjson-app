// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../product/product.dart';

part 'list_product_response.g.dart';

@JsonSerializable()
class ListProductResponse extends Equatable {
  const ListProductResponse({
    required this.products,
    required this.total,
    this.skip,
    this.limit,
  });

  final List<Product> products;
  final int total;
  final int? skip;
  final int? limit;

  factory ListProductResponse.fromJson(Map<String, dynamic> json) => _$ListProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListProductResponseToJson(this);

  ListProductResponse copyWith({
    List<Product>? products,
    int? total,
    int? skip,
    int? limit,
  }) {
    return ListProductResponse(
      products: products ?? this.products,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }

  @override
  List<Object?> get props => [
        products,
        total,
        skip,
        limit,
      ];
}
