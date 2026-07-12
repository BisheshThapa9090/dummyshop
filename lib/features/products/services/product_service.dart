import '../../../core/network/dio_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../models/product_model.dart';

class ProductService {
  final DioClient _dioClient = DioClient();

  Future<List<ProductModel>> getProducts({int limit = 20, int skip = 0}) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.products,
        queryParams: {'limit': limit, 'skip': skip},
      );
      final List<dynamic> products = response['products'] ?? [];
      return products.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await _dioClient.get('/products/$id');
      print('Product Response: $response'); // Debug
      return ProductModel.fromJson(response);
    } catch (e) {
      print('Error getting product: $e'); // Debug
      rethrow;
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.productsSearch,
        queryParams: {'q': query},
      );
      final List<dynamic> products = response['products'] ?? [];
      return products.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.categories);
      return List<String>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await _dioClient.get(
        '${ApiEndpoints.category}/$category',
      );
      final List<dynamic> products = response['products'] ?? [];
      return products.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}