part of 'user_additional_bloc.dart';

@immutable
abstract class UserAdditionalState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserAdditionalInitial extends UserAdditionalState {}

class UserAdditionalStepChanged extends UserAdditionalState {
  final int step;

  UserAdditionalStepChanged(this.step);

  @override
  List<Object?> get props => [step];
}

class UserAdditionalLoading extends UserAdditionalState {}

class UserAdditionalSubmitSuccess extends UserAdditionalState {}

class UserAdditionalSubmitFailure extends UserAdditionalState {
  final String error;

  UserAdditionalSubmitFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UserAdditional Submit Failure { error: $error }';
}
