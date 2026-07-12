import '../../../core/network/dio_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../models/user_model.dart';

class AuthService {
  final DioClient _dioClient = DioClient();

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 30,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.me);
      return UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.refresh,
        data: {'refreshToken': refreshToken},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}