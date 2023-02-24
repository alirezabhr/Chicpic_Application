part of 'user_additional_bloc.dart';

@immutable
abstract class UserAdditionalState {}

class UserAdditionalInitial extends UserAdditionalState {}

class UserAdditionalSubmitSuccess extends UserAdditionalState {}

class UserAdditionalSubmitFailure extends UserAdditionalState {}
