import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_endpoints.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onError: _onError,
    ));
  }

  Future<void> _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.read(key: 'accessToken');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  void _onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      await _secureStorage.delete(key: 'accessToken');
      await _secureStorage.delete(key: 'refreshToken');
    }
    return handler.next(error);
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParams);
      return response.data;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic data, Map<String, dynamic>? queryParams}) async {
    try {
      final response = await dio.post(path, data: data, queryParameters: queryParams);
      return response.data;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> put(String path, {dynamic data, Map<String, dynamic>? queryParams}) async {
    try {
      final response = await dio.put(path, data: data, queryParameters: queryParams);
      return response.data;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await dio.delete(path, queryParameters: queryParams);
      return response.data;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioError error) {
    if (error.type == DioErrorType.connectionTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return 'Connection timeout. Please try again.';
    }
    if (error.type == DioErrorType.connectionError) {
      return 'No internet connection. Please check your network.';
    }
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      if (statusCode == 400) return 'Bad request. Please check your input.';
      if (statusCode == 401) return 'Unauthorized. Please login again.';
      if (statusCode == 404) return 'Resource not found.';
      if (statusCode == 500) return 'Server error. Please try again later.';
      return error.response!.data?['message'] ?? 'Error: $statusCode';
    }
    return 'Something went wrong. Please try again.';
  }
}

