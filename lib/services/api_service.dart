import 'package:dio/dio.dart';

import 'package:chicpic/services/client.dart';

import 'package:chicpic/statics/url.dart';

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
}
