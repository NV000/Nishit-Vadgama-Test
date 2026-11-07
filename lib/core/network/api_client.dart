import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_url.dart';

class ApiClient {
  static final ApiClient instance = ApiClient._internal();

  factory ApiClient() => instance;

  ApiClient._internal();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  )..interceptors.add(
      PrettyDioLogger(requestHeader: true, requestBody: true),
    );

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await dio.get(endpoint, queryParameters: queryParameters);
    if (res.statusCode == 200) return res.data;
    return null;
  }
}
