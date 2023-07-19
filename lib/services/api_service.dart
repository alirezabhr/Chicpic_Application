import 'package:dio/dio.dart';

import 'package:chicpic/services/client.dart';

import 'package:chicpic/statics/url.dart';

import 'package:chicpic/models/pagination.dart';
import 'package:chicpic/models/auth/login_user_data.dart';
import 'package:chicpic/models/auth/signup_user_data.dart';
import 'package:chicpic/models/auth/user_additional.dart';
import 'package:chicpic/models/product/category.dart';
import 'package:chicpic/models/product/shop.dart';
import 'package:chicpic/models/product/variant.dart';
import 'package:chicpic/models/product/product.dart';

class APIService {
  // Users
  static Future<Response> userCheckAuthentication() async {
    return await Client.instance.get(
      APIUrls.checkAuthentication,
    );
  }

  static Future<void> requestVerificationCode(String email) async {
    Map data = {'email': email};
    await Client.instance.post(APIUrls.requestVerificationCode, data: data);
  }

  static Future<void> checkVerificationCode(String email, String code) async {
    Map data = {'email': email, 'code': code};
    await Client.instance.post(APIUrls.checkVerificationCode, data: data);
  }

  static Future<Response> signup(SignupUserData data) async {
    return await Client.instance.post(
      APIUrls.signup,
      data: data.toMap(),
    );
  }

  static Future<Response> login(LoginUserData data) async {
    return await Client.instance.post(
      APIUrls.login,
      data: data.toMap(),
    );
  }

  static Future<Response> createUserAdditional(UserAdditional data) async {
    return await Client.instance.post(
      APIUrls.userAdditional,
      data: data.toMap(),
    );
  }

  // Products
  static Future<List<Category>> getCategories(CategoryGender gender) async {
    Response response = await Client.instance.get(
      APIUrls.categories,
      queryParameters: {'gender': gender.abbreviation},
    );
    return response.data.map<Category>((e) => Category.fromMap(e)).toList();
  }

  static Future<Pagination<ProductPreview>> getCategoryProducts({
    required int id,
    int page = 1,
  }) async {
    Response response = await Client.instance.get(
      APIUrls.categoryProducts(categoryId: id, page: page),
    );

    return Pagination<ProductPreview>(
      count: response.data['count'],
      next: response.data['next'],
      previous: response.data['previous'],
      results: response.data['results']
          .map<ProductPreview>((e) => ProductPreview.fromMap(e))
          .toList(),
    );
  }

  static Future<Pagination<Shop>> getShops({int page = 1}) async {
    Response response = await Client.instance.get(APIUrls.shops(page: page));

    return Pagination<Shop>(
      count: response.data['count'],
      next: response.data['next'],
      previous: response.data['previous'],
      results:
          response.data['results'].map<Shop>((e) => Shop.fromMap(e)).toList(),
    );
  }

  static Future<Pagination<ProductPreview>> getShopProducts({
    required int id,
    int page = 1,
  }) async {
    Response response = await Client.instance.get(
      APIUrls.shopProducts(shopId: id, page: page),
    );

    return Pagination<ProductPreview>(
      count: response.data['count'],
      next: response.data['next'],
      previous: response.data['previous'],
      results: response.data['results']
          .map<ProductPreview>((e) => ProductPreview.fromMap(e))
          .toList(),
    );
  }

  static Future<Pagination<VariantPreview>> getVariants({int page = 1}) async {
    Response response = await Client.instance.get(APIUrls.variants(page: page));

    return Pagination<VariantPreview>(
      count: response.data['count'],
      next: response.data['next'],
      previous: response.data['previous'],
      results: response.data['results']
          .map<VariantPreview>((e) => VariantPreview.fromMap(e))
          .toList(),
    );
  }

  static Future<ProductDetail> getProduct(int productId) async {
    Response response =
        await Client.instance.get(APIUrls.productDetail(productId));
    return ProductDetail.fromMap(response.data);
  }
}
