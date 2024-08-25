import 'package:dio/dio.dart';

class SimpleException {
  final String message;

  SimpleException(this.message);
}

class ConnectionException extends DioError {
  @override
  final String message = 'Can not connect to server.';

  ConnectionException({required super.requestOptions});
}

class TimeoutException extends DioError {
  TimeoutException({required super.requestOptions});
}

class BadRequestException extends DioError {
  late final String? errorMessage;

  BadRequestException(DioError error)
      : super(requestOptions: error.requestOptions) {
    if (error.response?.data.values.length > 0) {
      final errorValue = error.response?.data.values.first;
      if (errorValue is List) {
        errorMessage = errorValue[0];
      } else if (errorValue is String) {
        errorMessage = errorValue;
      }
    }
  }
}

class UnAuthorizedException extends DioError {
  @override
  String message = 'You have to login.';

  UnAuthorizedException({required super.requestOptions});

  @override
  String toString() {
    return message;
  }
}

class NotFoundException extends DioError {
  NotFoundException({required super.requestOptions});
}

class TooManyRequestException extends DioError {
  TooManyRequestException({required super.requestOptions});
}

class InternalServerException extends DioError {
  @override
  String message = 'Server error.';

  InternalServerException({required super.requestOptions});

  @override
  String toString() {
    return message;
  }
}
