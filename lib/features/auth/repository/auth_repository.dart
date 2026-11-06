import 'package:dartz/dartz.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_url.dart';
import '../../../core/storage/secure_storage.dart';
import '../model/user_model.dart';

class AuthRepository {
  final ApiClient _client = ApiClient.instance;

  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        ApiUrl.login,
        body: {'email': email, 'password': password},
      );

      if (response == null) {
        return const Left('Login failed. Please try again.');
      }

      final result = response['result'];
      if (result == null) {
        final msg = response['message'] ?? 'Login failed.';
        return Left(msg.toString());
      }

      await SecureStorage.setAccessToken(result['access_token'] ?? '');
      await SecureStorage.setRefreshToken(result['refresh_token'] ?? '');

      final user = UserModel.fromJson(result['user'] ?? result);
      await SecureStorage.setUserJson(user.toJsonString());

      return Right(user);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> register({
    required String name,
    required String email,
    required String password,
    required String mobile,
  }) async {
    try {
      final response = await _client.post(
        ApiUrl.register,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'mobile_number': mobile,
        },
      );

      if (response == null) {
        return const Left('Registration failed. Please try again.');
      }

      final result = response['result'];
      if (result == null) {
        return Left(response['message']?.toString() ?? 'Registration failed.');
      }

      final user = UserModel.fromJson(result);
      return Right(user);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> logout() async {
    try {
      final refreshToken = await SecureStorage.getRefreshToken();
      await _client.post(
        ApiUrl.logout,
        body: {'refresh_token': refreshToken},
      );
      await SecureStorage.clear();
      return const Right(true);
    } on Exception catch (e) {
      await SecureStorage.clear();
      return Left(e.toString());
    }
  }

  Future<UserModel?> getCachedUser() async {
    final json = await SecureStorage.getUserJson();
    if (json == null || json.isEmpty) return null;
    return UserModel.fromJsonString(json);
  }
}
