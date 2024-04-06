import 'package:chicpic/models/auth/gender_choices.dart';
import 'package:chicpic/statics/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  late bool _showPersonalizedProducts;
  late GenderChoices _lastGenderCategory;

  SettingsRepository() {
    loadConfigs();
  }

  Future<void> loadConfigs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _showPersonalizedProducts =
        prefs.getBool(SharedPrefKeys.showPersonalized) ?? false;

    _lastGenderCategory = prefs.get(SharedPrefKeys.categoryGender) ==
            GenderChoices.men.abbreviation
        ? GenderChoices.men
        : GenderChoices.women;
  }

  bool get showPersonalizedProducts => _showPersonalizedProducts;

  GenderChoices get lastGenderCategory => _lastGenderCategory;

  Future<void> setPersonalizedProducts(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefKeys.showPersonalized, value);
    _showPersonalizedProducts = value;
  }

  Future<void> setGenderCategory(GenderChoices gender) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.categoryGender, gender.abbreviation);
    _lastGenderCategory = gender;
  }
}
