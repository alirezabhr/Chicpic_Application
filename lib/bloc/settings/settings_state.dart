part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  //TODO: remove the constructor parameter
  final bool showPersonalizedProducts;

  SettingsLoaded({required this.showPersonalizedProducts});
}

class SettingsError extends SettingsState {
  final String message;

  SettingsError(this.message);
}

class SettingsErrorUserAdditionalRequired extends SettingsError {
  SettingsErrorUserAdditionalRequired()
      : super('Please add your body size first');
}

class ShowPersonalizedProductsChanged extends SettingsState {
  final bool showPersonalizedProducts;

  ShowPersonalizedProductsChanged(this.showPersonalizedProducts);
}
