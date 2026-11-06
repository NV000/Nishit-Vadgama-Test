class ApiUrl {
  ApiUrl._();

  static const String _baseUrl = 'https://api.udaanitsolution.in';

  static String get baseUrl => _baseUrl;

  static const String login = '/api/login';
  static const String register = '/api/register-user';
  static const String logout = '/api/logout';
  static const String refreshToken = '/api/refresh-token';
  static const String updateProfile = '/api/update-profile';
  static const String getMaster = '/api/get-master';
}

