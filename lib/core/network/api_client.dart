import 'package:dio/dio.dart';
import 'api_url.dart';
import 'interceptors/network_interceptor.dart';
import 'interceptors/token_interceptor.dart';

class ApiClient {
  static final ApiClient instance = ApiClient._internal();

  factory ApiClient() => instance;

  ApiClient._internal();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Accept': 'application/json'},
    ),
  )..interceptors.addAll([
      TokenInterceptor(),
      NetworkInterceptor(),
    ]);

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await dio.get(endpoint, queryParameters: queryParameters);
    if (res.statusCode == 200) return res.data;
    return null;
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await dio.post(
      endpoint,
      data: body,
      queryParameters: queryParameters,
    );
    if (res.statusCode == 200) return res.data;
    return null;
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final res = await dio.delete(
      endpoint,
      queryParameters: queryParameters,
      data: body,
    );
    if (res.statusCode == 200) return res.data;
    return null;
  }
}
