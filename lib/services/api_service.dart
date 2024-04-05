import 'package:dio/dio.dart';

import 'package:chicpic/services/client.dart';

import 'package:chicpic/statics/urls.dart';

import 'package:chicpic/models/app_version.dart';
import 'package:chicpic/models/pagination.dart';
import 'package:chicpic/models/auth/login_user_data.dart';
import 'package:chicpic/models/auth/signup_user_data.dart';
import 'package:chicpic/models/auth/reset_password_data.dart';
import 'package:chicpic/models/auth/user_additional.dart';
import 'package:chicpic/models/auth/gender_choices.dart';
import 'package:chicpic/models/product/category.dart';
import 'package:chicpic/models/product/shop.dart';
import 'package:chicpic/models/product/variant.dart';
import 'package:chicpic/models/product/product.dart';

class APIService {
  static Future<List<AppVersion>> getVersions() async {
    Response response = await Dio().get(BaseUrls.appVersions);
    return response.data.map<AppVersion>((e) => AppVersion.fromMap(e)).toList();
  }

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

  static Future<void> resetPassword(ResetPasswordData data) async {
    await Client.instance.post(APIUrls.resetPassword, data: data.toMap());
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
      APIUrls.userAdditional(data.user),
      data: data.toMap(),
    );
  }

  static Future<Response> updateUserAdditional(UserAdditional data) async {
    return await Client.instance.put(
      APIUrls.userAdditional(data.user),
      data: data.toMap(),
    );
  }

  // Clothing
  static Future<List<Category>> getCategories(GenderChoices gender) async {
    Response response = await Client.instance.get(
      APIUrls.categories,
      queryParameters: {'gender': gender.abbreviation},
    );
    return response.data.map<Category>((e) => Category.fromMap(e)).toList();
  }

  static Future<Pagination<VariantPreview>> getCategoryVariants({
    required int id,
    bool shouldRecommend = false,
    int page = 1,
  }) async {
    Response response = await Client.instance.get(
      APIUrls.categoryVariants(
        categoryId: id,
        recommend: shouldRecommend,
        page: page,
      ),
    );

    return Pagination<VariantPreview>(
      count: response.data['count'],
      next: response.data['next'],
      previous: response.data['previous'],
      results: response.data['results']
          .map<VariantPreview>((e) => VariantPreview.fromMap(e))
          .toList(),
    );
  }

  static Future<Pagination<VariantPreview>> getDiscountedVariants({
    required int discount,
    required GenderChoices genderChoices,
    bool shouldRecommend = false,
    int page = 1,
  }) async {
    Response response = await Client.instance.get(
      APIUrls.discountedVariants(
        discount,
        genderChoices.abbreviation,
        recommend: shouldRecommend,
        page: page,
      ),
    );

    return Pagination<VariantPreview>(
      count: response.data['count'],
      next: response.data['next'],
      previous: response.data['previous'],
      results: response.data['results']
          .map<VariantPreview>((e) => VariantPreview.fromMap(e))
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

  static Future<Pagination<VariantPreview>> exploreVariants({
    bool shouldRecommend = false,
    int page = 1,
  }) async {
    Response response = await Client.instance.get(
      APIUrls.exploreVariants(recommend: shouldRecommend, page: page),
    );

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

  static Future<Pagination<VariantPreview>> searchVariant({
    required String searchText,
    int page = 1,
  }) async {
    Response response = await Client.instance.get(
      APIUrls.searchVariant(searchText: searchText, page: page),
    );

    return Pagination<VariantPreview>(
      count: response.data['count'],
      next: response.data['next'],
      previous: response.data['previous'],
      results: response.data['results']
          .map<VariantPreview>((e) => VariantPreview.fromMap(e))
          .toList(),
    );
  }

  static Future<void> saveVariant(int userId, int variantId) async {
    Map data = {'user': userId, 'variant': variantId};
    await Client.instance.post(APIUrls.saveVariant, data: data);
  }

  static Future<void> unsaveVariant(int userId, int variantId) async {
    Map data = {'user': userId, 'variant': variantId};
    await Client.instance.delete(APIUrls.saveVariant, data: data);
  }

  static Future<void> trackVariant(int userId, int variantId) async {
    Map data = {'user': userId, 'variant': variantId};
    await Client.instance.post(APIUrls.trackVariant, data: data);
  }

  static Future<void> untrackVariant(int userId, int variantId) async {
    Map data = {'user': userId, 'variant': variantId};
    await Client.instance.delete(APIUrls.trackVariant, data: data);
  }

  static Future<Pagination<VariantPreview>> retrieveSavedVariants(int userId,
      {int page = 1}) async {
    Response response = await Client.instance.get(
      APIUrls.savedVariants(userId: userId, page: page),
    );

    return Pagination<VariantPreview>(
      count: response.data['count'],
      next: response.data['next'],
      previous: response.data['previous'],
      results: response.data['results']
          .map<VariantPreview>((e) => VariantPreview.fromMap(e))
          .toList(),
    );
  }
}
