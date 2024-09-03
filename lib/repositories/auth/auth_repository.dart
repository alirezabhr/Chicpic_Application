import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/statics/shared_preferences_keys.dart';

import 'package:chicpic/models/auth/auth_types.dart';
import 'package:chicpic/models/auth/user.dart';
import 'package:chicpic/models/auth/token.dart';
import 'package:chicpic/models/auth/login_user_data.dart';
import 'package:chicpic/models/auth/signup_user_data.dart';
import 'package:chicpic/models/auth/user_additional.dart';

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

  Future<String?> getUserAuthType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.userAuthType);
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

  Future<void> saveUserAuthType(AuthType authType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.userAuthType, authType.name);
  }

  Future<void> saveUserAdditionalReminder({int remindIn = 0}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Set reminder to next request
    prefs.setInt(SharedPrefKeys.userAdditionalReminder, remindIn);
  }

  Future<void> saveUserDefaultSettings({required AuthType authType}) async {
    await saveUserAuthType(authType);
    await saveUserAdditionalReminder();
  }

  Future<void> clearUserTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPrefKeys.userAccessToken);
    prefs.remove(SharedPrefKeys.userRefreshToken);
  }

  Future<void> verifyUser() async {
    _user = _user!.copyWith(isVerified: true);
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
    saveUserDefaultSettings(authType: AuthType.email);
  }

  Future<void> login(LoginUserData data) async {
    final Response response = await APIService.login(data);
    _user = User.fromMap(response.data);
    saveUserTokens(_user!.tokens);
    saveUserDefaultSettings(authType: AuthType.email);
  }

  Future<void> socialAuthentication({
    required AuthType authType,
    required String accessToken,
  }) async {
    final Response response = await APIService.socialAuth(authType, accessToken);
    _user = User.fromSocialAuthResponse(response.data);
    saveUserTokens(_user!.tokens);
    saveUserDefaultSettings(authType: authType);
  }

  Future<void> submitUserAdditional(UserAdditional data) async {
    late final Response response;
    if (_user!.userAdditional != null) {
      // Update user additional
      response = await APIService.updateUserAdditional(data);
    } else {
      // Create user additional
      response = await APIService.createUserAdditional(data);
    }
    _user = _user!.copyWith(
      userAdditional: UserAdditional.fromJson(response.data),
    );
  }

  Future<bool> shouldRemindUserAdditional() async {
    if (_user?.userAdditional == null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? reminder = prefs.getInt(SharedPrefKeys.userAdditionalReminder);
      if (reminder == null) {
        await saveUserAdditionalReminder(remindIn: 5);
        return true;
      }
      if (reminder > 0) {
        await saveUserAdditionalReminder(remindIn: reminder - 1);
        return false;
      } else {
        await saveUserAdditionalReminder(remindIn: 5);
        return true;
      }
    } else {
      return false;
    }
  }
}
