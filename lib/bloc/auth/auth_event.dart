part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Fired just after the app is launched
class AppLoaded extends AuthEvent {}

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

class AuthLogout extends AuthEvent {}
