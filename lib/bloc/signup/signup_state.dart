part of 'signup_bloc.dart';

@immutable
abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

abstract class SignupLoading extends SignupState {}

class SignupLoadingWithForm extends SignupLoading {}

class SignupLoadingSocialAuth extends SignupLoading {}

class SignupFailure extends SignupState {
  final String error;

  SignupFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignupSuccess extends SignupState {}
