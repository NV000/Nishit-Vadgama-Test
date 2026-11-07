import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const String _keyAccessToken = 'access_token';
  static const String _keyUserJson = 'user_json';
  static const String _keyLocale = 'selected_locale';

  static Future<void> setAccessToken(String token) =>
      _storage.write(key: _keyAccessToken, value: token);

  static Future<String> getAccessToken() async =>
      await _storage.read(key: _keyAccessToken) ?? '';

  static Future<void> setUserJson(String json) =>
      _storage.write(key: _keyUserJson, value: json);

  static Future<String?> getUserJson() => _storage.read(key: _keyUserJson);

  static Future<void> setLocale(String languageCode) =>
      _storage.write(key: _keyLocale, value: languageCode);

  static Future<String?> getLocale() => _storage.read(key: _keyLocale);

  static Future<void> clear() => _storage.deleteAll();
}
