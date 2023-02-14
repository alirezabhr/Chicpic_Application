abstract class BaseUrls {
  static const String http = 'http://';
  static const String https = 'https://';
  static const String _developmentBaseUrl = '${http}10.0.2.2:8000/';
  static const String baseUrl = _developmentBaseUrl;
}

abstract class APIUrls {
  // User Apis
  static const String _users = 'users/';

  static const String checkAuthentication = '${_users}details/';
  static const String login = '${_users}login/';
  static const String signup = '${_users}signup/';
  static const String requestVerificationCode = '${_users}otp/request/';
  static const String checkVerificationCode = '${_users}otp/verify/';
  static const String tokenRefresh = '${_users}token/refresh/';
}