import '../../../core/network/dio_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../models/cart_model.dart';

class CartService {
  final DioClient _dioClient = DioClient();

  Future<CartModel> getCart(int userId) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.carts,
        queryParams: {'userId': userId},
      );
      final carts = response['carts'] as List? ?? [];
      if (carts.isNotEmpty) {
        return CartModel.fromJson(carts[0]);
      }
      return _createEmptyCart();
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> addToCart(int userId, int productId, int quantity) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.cartAdd,
        data: {
          'userId': userId,
          'products': [{'id': productId, 'quantity': quantity}],
        },
      );
      return CartModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> updateCart(int cartId, List<Map<String, dynamic>> products) async {
    try {
      final response = await _dioClient.put(
        ApiEndpoints.cartById(cartId),
        data: {
          'products': products,
          'merge': false,
        },
      );
      return CartModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCart(int cartId) async {
    try {
      await _dioClient.delete(ApiEndpoints.cartById(cartId));
    } catch (e) {
      rethrow;
    }
  }

  CartModel _createEmptyCart() {
    return CartModel(
      id: 0,
      userId: 0,
      products: [],
      total: 0,
      discountedTotal: 0,
      totalProducts: 0,
      totalQuantity: 0,
    );
  }
}

