abstract class BaseUrls {
  static const String http = 'http://';
  static const String https = 'https://';
  static const String _developmentBaseUrl = '${http}10.0.2.2:8000/';
  static const String baseUrl = _developmentBaseUrl;
}

abstract class APIUrls {
  // Users APIs
  static const String _users = 'users/';

  static const String checkAuthentication = '${_users}details/';
  static const String login = '${_users}login/';
  static const String signup = '${_users}signup/';
  static const String requestVerificationCode = '${_users}otp/request/';
  static const String checkVerificationCode = '${_users}otp/verify/';
  static const String tokenRefresh = '${_users}token/refresh/';
  static String userAdditional(int userId) {
    return '$_users$userId/additional/';
  }

  // Clothing APIs
  static const String _clothing = 'clothing/';

  static const String categories = '${_clothing}categories/';
  static const String products = '${_clothing}products/';

  static String categoryProducts({required int categoryId, int page = 1}) {
    return '$categories$categoryId/products/?page=$page';
  }

  static String shops({int page = 1}) {
    return '${_clothing}shops/?page=$page';
  }

  static String shopProducts({required int shopId, int page = 1}) {
    return '${_clothing}shops/$shopId/products/?page=$page';
  }

  static String exploreVariants({int page = 1}) {
    return '${_clothing}explore/variants/?page=$page';
  }

  static String productDetail(int productId) {
    return '$products$productId/';
  }

  static String discountedProducts(int discount, {int page = 1}) {
    return '$products?discount=$discount&page=$page';
  }

  static String searchProduct({required String searchText, int page = 1}) {
    return '${_clothing}search/products/?q=$searchText&page=$page';
  }

  static const String saveVariant = '${_clothing}save/';
  static const String trackVariant = '${_clothing}track/';

  static String savedVariants({required int userId, int page = 1}) {
    return '${_clothing}saved/$userId/?page=$page';
  }
}
