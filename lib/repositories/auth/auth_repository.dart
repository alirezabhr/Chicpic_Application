import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/statics/shared_preferences_keys.dart';

import 'package:chicpic/models/auth/user.dart';
import 'package:chicpic/models/auth/token.dart';
import 'package:chicpic/models/auth/login_user_data.dart';
import 'package:chicpic/models/auth/signup_user_data.dart';

const String _tokenPrefix = 'Bearer';

class AuthRepository {
  User? _user;

  User? get user => _user;

  Future<String?> get userAccessToken async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefKeys.userAccessToken);
    if (token != null) {
      return '$_tokenPrefix $token';
    }
    return null;
  }

  Future<String?> get userRefreshToken async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.userRefreshToken);
  }

  Future<void> saveUserAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _user?.tokens.accessToken = accessToken;
    prefs.setString(SharedPrefKeys.userAccessToken, accessToken);
  }

  Future<void> saveUserRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _user?.tokens.refreshToken = refreshToken;
    prefs.setString(SharedPrefKeys.userRefreshToken, refreshToken);
  }

  Future<void> saveUserTokens(UserToken tokens) async {
    await saveUserAccessToken(tokens.accessToken);
    await saveUserRefreshToken(tokens.refreshToken);
  }

  Future<void> clearUserTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPrefKeys.userAccessToken);
    prefs.remove(SharedPrefKeys.userRefreshToken);
  }

  Future<void> verifyUser() async {
    _user?.verify();
  }

  Future<void> logout() async {
    _user = null;
    clearUserTokens();
  }

  Future<void> userCheckAuthentication() async {
    final Response response = await APIService.userCheckAuthentication();
    _user = User.fromMap(response.data);
  }

  Future<void> signup(SignupUserData data) async {
    final Response response = await APIService.signup(data);
    _user = User.fromMap(response.data);
    saveUserTokens(_user!.tokens);
  }

  Future<void> login(LoginUserData data) async {
    final Response response = await APIService.login(data);
    _user = User.fromMap(response.data);
    saveUserTokens(_user!.tokens);
  }
}
