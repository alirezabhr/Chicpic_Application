import 'package:dio/dio.dart';

import 'package:chicpic/statics/urls.dart';
import 'package:chicpic/services/client_interceptor.dart';

abstract class Client {
  static Dio get instance {
    return Dio(
      BaseOptions(
        baseUrl: BaseUrls.baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 9000,
      ),
    )..interceptors.add(
      ClientInterceptor(),
    );
  }
}
