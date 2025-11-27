import '../../data/model/cart/cart.dart';
import '../../data/model/cart/cart_item.dart';

abstract class CartRepository {
  Future<Cart> getCart();
  Future<CartItem> addToCart(CartItem item);
  Future<CartItem> updateCartItem(CartItem item);
  void removeFromCart(CartItem item);
}