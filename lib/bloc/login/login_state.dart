part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

abstract class LoginLoading extends LoginState {}

class LoginLoadingWithForm extends LoginLoading {}

class LoginLoadingSocialAuth extends LoginLoading {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginInvalidCredentials extends LoginFailure {
  LoginInvalidCredentials()
      : super(error: 'Username and password do not match');
}

class LoginAccountNotVerified extends LoginFailure {
  LoginAccountNotVerified() : super(error: 'Your account is not verified');
}

class LoginSuccess extends LoginState {}
