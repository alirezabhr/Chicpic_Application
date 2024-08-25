import 'package:dio/dio.dart';

import 'package:chicpic/services/exceptions.dart';

import 'package:chicpic/statics/urls.dart';

import 'package:chicpic/repositories/auth/auth_repository.dart';

import 'package:chicpic/models/auth/token.dart';

class ClientInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? userToken = await AuthRepository().userAccessToken;
    if (userToken != null) {
      options.headers['Authorization'] = userToken;
    }
    super.onRequest(options, handler);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        super.onError(
            TimeoutException(requestOptions: err.requestOptions), handler);
        break;
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            super.onError(BadRequestException(err), handler);
            break;
          case 401:
            super.onError(
                UnAuthorizedException(requestOptions: err.requestOptions),
                handler);
            break;
          case 403:
            try {
              await refreshToken();
              Response response = await retryRequest(err.requestOptions);
              return handler.resolve(response);
            } catch (_) {
              await AuthRepository().clearUserTokens();
              super.onError(
                UnAuthorizedException(requestOptions: err.requestOptions),
                handler,
              );
            }
            break;
          case 404:
            super.onError(
              NotFoundException(requestOptions: err.requestOptions),
              handler,
            );
            break;
          case 429:
            super.onError(
              TooManyRequestException(requestOptions: err.requestOptions),
              handler,
            );
            break;
          case 500:
            super.onError(
                InternalServerException(requestOptions: err.requestOptions),
                handler);
            break;
          default:
            super.onError(err, handler);
        }
        break;
      case DioErrorType.other:
        super.onError(
            ConnectionException(requestOptions: err.requestOptions), handler);
        break;
      default:
        super.onError(err, handler);
    }
  }

  Future<Response> retryRequest(RequestOptions requestOptions) async {
    final Dio dio = Dio(BaseOptions(baseUrl: BaseUrls.baseUrl));
    final String? userToken = await AuthRepository().userAccessToken;
    if (userToken != null) {
      dio.options.headers['Authorization'] = userToken;
    }
    // TODO check if it is only sending "get" requests
    return await dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }

  Future<void> refreshToken() async {
    AuthRepository authRepository = AuthRepository();
    final String? refresh = await authRepository.userRefreshToken;

    if (refresh == null) throw Exception('Refresh token not found');

    Map<String, String> data = {'refresh': refresh};
    Dio dio = Dio(BaseOptions(baseUrl: BaseUrls.baseUrl));
    Response response = await dio.post(APIUrls.tokenRefresh, data: data);

    authRepository.saveUserTokens(UserToken.fromJson(response.data));
  }
}
