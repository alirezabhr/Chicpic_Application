part of 'user_additional_bloc.dart';

@immutable
abstract class UserAdditionalEvent extends Equatable {
  @override
  get props => [];
}

class UserAdditionalInitialize extends UserAdditionalEvent {}

class UserAdditionalChangeStep extends UserAdditionalEvent {
  final bool increasing;

  UserAdditionalChangeStep({required this.increasing});

  @override
  get props => [increasing];
}

class UserAdditionalSubmit extends UserAdditionalEvent {}