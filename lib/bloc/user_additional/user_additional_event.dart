part of 'user_additional_bloc.dart';

@immutable
abstract class UserAdditionalEvent extends Equatable {
  @override
  get props => [];
}

class UserAdditionalChangeStep extends UserAdditionalEvent {
  final bool increasing;

  UserAdditionalChangeStep({required this.increasing});

  @override
  get props => [increasing];
}

class UserAdditionalSubmit extends UserAdditionalEvent {}