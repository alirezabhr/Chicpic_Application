import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chicpic/repositories/auth/auth_repository.dart';
import 'package:chicpic/repositories/settings/settings_repository.dart';
import 'package:chicpic/statics/shared_preferences_keys.dart';
import 'package:chicpic/models/auth/gender_choices.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AuthRepository _authRepo;
  final SettingsRepository _settingsRepo;

  SettingsBloc(this._authRepo, this._settingsRepo) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateShowPersonalizedProducts>(_onUpdateShowPersonalizedProducts);
    on<UpdateGenderCategory>(_onUpdateGenderCategory);
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _settingsRepo.showPersonalizedProducts =
        prefs.getBool(SharedPrefKeys.showPersonalized) ?? false;

    _settingsRepo.lastGenderCategory =
        prefs.get(SharedPrefKeys.categoryGender) ==
                GenderChoices.men.abbreviation
            ? GenderChoices.men
            : GenderChoices.women;

    emit(SettingsLoaded());
  }

  void _onUpdateShowPersonalizedProducts(
    UpdateShowPersonalizedProducts event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if user additional is null and user wants recommendations
    if (event.showPersonalizedProducts &&
        _authRepo.user!.userAdditional == null) {
      emit(SettingsErrorUserAdditionalRequired());
    } else {
      prefs.setBool(
        SharedPrefKeys.showPersonalized,
        event.showPersonalizedProducts,
      );
      _settingsRepo.showPersonalizedProducts = event.showPersonalizedProducts;

      // Change gender category if user wants recommendations
      if (event.showPersonalizedProducts) {
        final prefs = await SharedPreferences.getInstance();
        final gender = _authRepo.user!.userAdditional!.genderInterested;
        prefs.setString(SharedPrefKeys.categoryGender, gender.abbreviation);
        _settingsRepo.lastGenderCategory = gender;
      }
      //TODO: REFACTOR the above and below code to a function

      emit(SettingsShowPersonalizedProductsUpdated());
    }
  }

  void _onUpdateGenderCategory(
    UpdateGenderCategory event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.categoryGender, event.gender.abbreviation);
    _settingsRepo.lastGenderCategory = event.gender;
    emit(SettingsLoaded());
  }
}
