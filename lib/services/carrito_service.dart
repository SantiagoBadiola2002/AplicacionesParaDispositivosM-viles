import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartService {
  static const String _cartKey = 'cart';

  // Agregar producto al carrito
  Future<void> addProduct(String productId, int quantity) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = _getCartFromPrefs(prefs);
    
    if (cart.containsKey(productId)) {
      cart[productId] = quantity;
    } else {
      cart[productId] = quantity;
    }

    await prefs.setString(_cartKey, jsonEncode(cart));
  }

  // Obtener productos del carrito
  Future<Map<String, int>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    return _getCartFromPrefs(prefs);
  }

  // Eliminar un producto del carrito
  Future<void> removeProduct(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = _getCartFromPrefs(prefs);

    cart.remove(productId);
    await prefs.setString(_cartKey, jsonEncode(cart));
  }

  // Vaciar el carrito
  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  // Obtener el carrito desde SharedPreferences
  Map<String, int> _getCartFromPrefs(SharedPreferences prefs) {
    final cartString = prefs.getString(_cartKey);
    if (cartString == null) return {};

    final Map<String, dynamic> cartJson = jsonDecode(cartString);
    return Map<String, int>.from(cartJson);
  }
}
