import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../services/cart_service.dart';
import '../../products/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final CartService _cartService = CartService();

  CartModel? _cart;
  bool _isLoading = false;
  String? _error;

  CartModel? get cart => _cart;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get itemCount => _cart?.totalQuantity ?? 0;
  double get total => _cart?.discountedTotal ?? 0;

  Future<void> loadCart(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cart = await _cartService.getCart(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addItem({
    required int userId,
    required int productId,
    required int quantity,
    required ProductModel product,
  }) {
    if (_cart == null) {
      _cart = CartModel(
        id: 1,
        userId: userId,
        products: [],
        total: 0,
        discountedTotal: 0,
        totalProducts: 0,
        totalQuantity: 0,
      );
    }

    final existingIndex = _cart!.products.indexWhere((item) => item.id == productId);

    if (existingIndex != -1) {
      final existingItem = _cart!.products[existingIndex];
      _cart!.products[existingIndex] = CartItem(
        id: existingItem.id,
        title: existingItem.title,
        price: existingItem.price,
        discountedPrice: existingItem.discountedPrice,
        quantity: existingItem.quantity + quantity,
        thumbnail: existingItem.thumbnail,
      );
    } else {
      _cart!.products.add(
        CartItem(
          id: productId,
          title: product.title,
          price: product.price,
          discountedPrice: product.discountedPrice,
          quantity: quantity,
          thumbnail: product.thumbnail,
        ),
      );
    }

    _updateTotals();
    notifyListeners();
  }

  void _updateTotals() {
    double total = 0;
    double discountedTotal = 0;
    int totalQuantity = 0;

    for (final item in _cart!.products) {
      total += item.price * item.quantity;
      discountedTotal += item.discountedPrice * item.quantity;
      totalQuantity += item.quantity;
    }

    _cart = CartModel(
      id: _cart!.id,
      userId: _cart!.userId,
      products: _cart!.products,
      total: total,
      discountedTotal: discountedTotal,
      totalProducts: _cart!.products.length,
      totalQuantity: totalQuantity,
    );
  }

  Future<void> updateQuantity(int cartItemId, int quantity) async {
    if (_cart == null) return;

    final index = _cart!.products.indexWhere((item) => item.id == cartItemId);
    if (index == -1) return;

    if (quantity <= 0) {
      _cart!.products.removeAt(index);
    } else {
      final item = _cart!.products[index];
      _cart!.products[index] = CartItem(
        id: item.id,
        title: item.title,
        price: item.price,
        discountedPrice: item.discountedPrice,
        quantity: quantity,
        thumbnail: item.thumbnail,
      );
    }

    _updateTotals();
    notifyListeners();
  }

  Future<void> removeItem(int cartItemId) async {
    await updateQuantity(cartItemId, 0);
  }

  void clearCart() {
    _cart = null;
    notifyListeners();
  }
}
