import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BaseUrls {
  static const String http = 'http://';
  static const String https = 'https://';

  static const String _androidDevelopmentBaseUrl = '${http}10.0.2.2:8000/';
  static const String _iosDevelopmentBaseUrl = '${http}127.0.0.1:8000/';
  static final String _developmentBaseUrl =
      Platform.isAndroid ? _androidDevelopmentBaseUrl : _iosDevelopmentBaseUrl;

  static const String _productionBaseUrl = '${http}99.79.190.129/';
  static final String baseUrl = dotenv.env['IS_PRODUCTION'] == 'true'
      ? _productionBaseUrl
      : _developmentBaseUrl;
  static const String appVersions =
      "https://xmzcs0kq2d.execute-api.ca-central-1.amazonaws.com/chicpic_dev";
}

abstract class APIUrls {
  // Users APIs
  static const String _users = 'users/';

  static const String checkAuthentication = '${_users}details/';
  static const String login = '${_users}login/';
  static const String signup = '${_users}signup/';
  static const String requestVerificationCode = '${_users}otp/request/';
  static const String checkVerificationCode = '${_users}otp/verify/';
  static const String resetPassword = '${_users}reset-password/';
  static const String tokenRefresh = '${_users}token/refresh/';

  static String userAdditional(int userId) {
    return '$_users$userId/additional/';
  }

  static String socialAuth({required String provider}) {
    return '${_users}social-auth/$provider/';
  }

  // Clothing APIs
  static const String _clothing = 'clothing/';

  static const String categories = '${_clothing}categories/';
  static const String products = '${_clothing}products/';
  static const String variants = '${_clothing}variants/';

  static String categoryVariants({
    required int categoryId,
    bool recommend = false,
    int page = 1,
  }) {
    return '$categories$categoryId/variants/?recom=$recommend&page=$page';
  }

  static String shops({int page = 1}) {
    return '${_clothing}shops/?page=$page';
  }

  static String shopVariants({
    required int shopId,
    recommend = false,
    int page = 1,
  }) {
    return '${_clothing}shops/$shopId/variants/?recom=$recommend&page=$page';
  }

  static String exploreVariants({bool recommend = false, int page = 1}) {
    return '${_clothing}explore/variants/?recom=$recommend&page=$page';
  }

  static String productDetail(int productId) {
    return '$products$productId/';
  }

  static String discountedVariants(
    int discount,
    String gender, {
    bool recommend = false,
    int page = 1,
  }) {
    return '$variants?discount=$discount&gender=$gender&recom=$recommend&page=$page';
  }

  static String searchVariant({required String searchText, int page = 1}) {
    return '${_clothing}search/?q=$searchText&page=$page';
  }

  static const String saveVariant = '${_clothing}save/';
  static const String trackVariant = '${_clothing}track/';

  static String savedVariants({required int userId, int page = 1}) {
    return '${_clothing}saved/$userId/?page=$page';
  }
}
