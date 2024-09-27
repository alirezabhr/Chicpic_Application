part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Fired just after the app is launched
class AppLoaded extends AuthEvent {}

class SignupWithCredentials extends AuthEvent {
  final SignupUserData signupData;

  const SignupWithCredentials(this.signupData);

  @override
  List<Object> get props => [signupData];
}

class LoginWithCredentials extends AuthEvent {
  final LoginUserData loginData;

  const LoginWithCredentials(this.loginData);

  @override
  List<Object> get props => [loginData];
}

class GoogleAuthRequest extends AuthEvent {}

class AuthRequestVerificationCode extends AuthEvent {
  final String email;

  const AuthRequestVerificationCode(this.email);

  @override
  List<Object> get props => [email];
}

class AuthCheckVerificationCode extends AuthEvent {
  final String email;
  final String code;

  const AuthCheckVerificationCode(this.email, this.code);

  @override
  List<Object> get props => [email, code];
}

class AuthResetPassword extends AuthEvent {
  final ResetPasswordData resetPasswordData;

  const AuthResetPassword(this.resetPasswordData);

  @override
  List<Object> get props => [resetPasswordData];
}

class AuthUpdateBirthdate extends AuthEvent {
  final DateTime birthdate;

  const AuthUpdateBirthdate(this.birthdate);

  @override
  List<Object> get props => [birthdate];
}

class AuthDeleteUser extends AuthEvent {}

class AuthLogout extends AuthEvent {}
