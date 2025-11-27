// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/cart_repository.dart';
import '../datasource/local/database/app_database.dart';
import '../model/cart/cart.dart';
import '../model/cart/cart_item.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final AppDB appDB;

  CartRepositoryImpl({required this.appDB});

  @override
  Future<Cart> getCart() async {
    final List<CartItem> cartItems = await appDB
        .select(appDB.cartItemTable)
        .map((data) => CartItem(product: data.product, quantity: data.quantity))
        .get();
    return Cart(items: cartItems);
  }

  @override
  Future<CartItem> addToCart(CartItem item) async {
    final newItem = await appDB
        .into(appDB.cartItemTable)
        .insertReturning(CartItemTableCompanion(product: Value(item.product), quantity: Value(item.quantity)));
    return item.copyWith(id: newItem.id);
  }

  @override
  void removeFromCart(CartItem item) {
    return appDB.delete(appDB.cartItemTable).where((tbl) => tbl.id.equalsNullable(item.id));
  }

  @override
  Future<CartItem> updateCartItem(CartItem item) async {
    await appDB
        .update(appDB.cartItemTable)
        .replace(CartItemTableData(id: item.id!, product: item.product, quantity: item.quantity));
    return item;
  }
}
