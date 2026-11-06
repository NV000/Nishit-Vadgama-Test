import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          message: 'No internet connection',
        ),
      );
      Get.snackbar(
        'No Internet',
        'Please check your connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    super.onRequest(options, handler);
  }
}

