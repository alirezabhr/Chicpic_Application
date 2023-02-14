part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginWithUsernamePassword extends LoginEvent {
  final LoginUserData userData;

  LoginWithUsernamePassword({
    required this.userData,
  });

  @override
  List<Object> get props => [userData];
}

class SocialLoginWithGoogle extends LoginEvent {}