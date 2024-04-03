part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class SetShowPersonalizedProducts extends SettingsEvent {
  final bool showPersonalizedProducts;

  SetShowPersonalizedProducts(this.showPersonalizedProducts);
}

class SetGenderCategory extends SettingsEvent {
  final GenderChoices gender;

  SetGenderCategory(this.gender);
}

