part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

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
