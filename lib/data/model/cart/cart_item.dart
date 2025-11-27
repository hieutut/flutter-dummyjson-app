// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../product/product.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem extends Equatable {
  final int? id;
  final Product product;
  final int quantity;

  const CartItem({this.id, required this.product, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);

  CartItem copyWith({int? id, Product? product, int? quantity}) {
    return CartItem(id: id ?? this.id, product: product ?? this.product, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [id, product, quantity];
}
