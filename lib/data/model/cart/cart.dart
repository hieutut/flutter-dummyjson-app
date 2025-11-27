// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cart_item.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart extends Equatable {
  final List<CartItem> items;

  const Cart({this.items = const []});

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  String get totalItemsDisplay => totalItems <= 99 ? totalItems.toString() : '99+';

  double get totalPrice => items.fold(0, (sum, item) => sum + item.product.finalPrice);

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);

  Cart copyWith({List<CartItem>? items}) {
    return Cart(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}
