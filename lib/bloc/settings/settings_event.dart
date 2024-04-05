part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class UpdateShowPersonalizedProducts extends SettingsEvent {
  final bool showPersonalizedProducts;

  UpdateShowPersonalizedProducts(this.showPersonalizedProducts);
}

class UpdateGenderCategory extends SettingsEvent {
  final GenderChoices gender;

  UpdateGenderCategory(this.gender);
}

