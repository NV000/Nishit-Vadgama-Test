import 'package:dio/dio.dart';
import '../../storage/secure_storage.dart';
import '../api_url.dart';
import '../api_client.dart';

class TokenInterceptor extends Interceptor {
  static bool _isRefreshing = false;
  static final List<({RequestOptions options, ErrorInterceptorHandler handler})>
      _queue = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorage.getAccessToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final path = err.requestOptions.path;
    final isAuthPath = path.contains(ApiUrl.login) ||
        path.contains(ApiUrl.logout) ||
        path.contains(ApiUrl.refreshToken);

    if (err.response?.statusCode == 401 && path.contains(ApiUrl.refreshToken)) {
      _rejectAll(err);
      await _forceLogout();
      return handler.reject(err);
    }

    if (err.response?.statusCode == 401 && !isAuthPath) {
      final refresh = await SecureStorage.getRefreshToken();
      if (refresh.isEmpty) {
        await _forceLogout();
        return handler.reject(err);
      }

      if (_isRefreshing) {
        _queue.add((options: err.requestOptions, handler: handler));
        return;
      }

      _isRefreshing = true;
      try {
        final refreshed = await _doRefresh(refresh);
        if (refreshed) {
          final newToken = await SecureStorage.getAccessToken();
          final original = err.requestOptions;
          original.headers['Authorization'] = 'Bearer $newToken';
          final res = await ApiClient.dio.fetch(original);
          handler.resolve(res);
          final copy = List.of(_queue);
          _queue.clear();
          for (final req in copy) {
            req.options.headers['Authorization'] = 'Bearer $newToken';
            try {
              final r = await ApiClient.dio.fetch(req.options);
              req.handler.resolve(r);
            } catch (e) {
              if (e is DioException) req.handler.reject(e);
            }
          }
          return;
        } else {
          _rejectAll(err);
          await _forceLogout();
          return handler.reject(err);
        }
      } finally {
        _isRefreshing = false;
      }
    }
    super.onError(err, handler);
  }

  Future<bool> _doRefresh(String refreshToken) async {
    try {
      final res = await Dio().post(
        '${ApiUrl.baseUrl}${ApiUrl.refreshToken}',
        data: {'refresh_token': refreshToken},
      );
      if (res.statusCode == 200 && res.data?['result']?['access_token'] != null) {
        await SecureStorage.setAccessToken(res.data['result']['access_token']);
        final newRefresh = res.data['result']['refresh_token'];
        if (newRefresh != null) await SecureStorage.setRefreshToken(newRefresh);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> _forceLogout() async {
    await SecureStorage.clear();
  }

  void _rejectAll(DioException err) {
    final copy = List.of(_queue);
    _queue.clear();
    for (final req in copy) {
      req.handler.reject(err);
    }
  }
}

