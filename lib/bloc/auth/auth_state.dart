part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupFailure extends AuthState {
  final String error;

  SignupFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
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

class AuthConnectionProblem extends AuthState {}

class AuthNotVerified extends AuthState {}

class AuthNotAuthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {}

class VerificationLoading extends AuthState {}

class VerificationSent extends AuthState {}

class VerificationSuccess extends AuthState {}

class VerificationFailure extends AuthState {
  final String error;

  VerificationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class AuthResetPasswordSuccess extends AuthState {}

class AuthResetPasswordFailure extends AuthState {
  final String error;

  AuthResetPasswordFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
