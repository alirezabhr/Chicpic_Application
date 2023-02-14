part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupFormButtonPressed extends SignupEvent {
  final SignupUserData signupData;

  SignupFormButtonPressed({required this.signupData});

  @override
  List<Object?> get props => [signupData];
}

class SocialSignupWithGoogle extends SignupEvent {}