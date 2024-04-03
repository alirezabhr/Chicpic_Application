import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chicpic/repositories/auth/auth_repository.dart';
import 'package:chicpic/statics/shared_preferences_keys.dart';
import 'package:chicpic/models/auth/gender_choices.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AuthRepository _authRepository;
  late bool _showPersonalizedProducts;
  late GenderChoices _lastGenderCategory;

  SettingsBloc(this._authRepository) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<SetShowPersonalizedProducts>(_onSetShowPersonalizedProducts);
    on<SetGenderCategory>(_onSetGenderCategory);
  }

  AuthRepository get authRepository => _authRepository;

  bool get showPersonalizedProducts => _showPersonalizedProducts;

  GenderChoices get lastGenderCategory => _lastGenderCategory;

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _showPersonalizedProducts =
        prefs.getBool(SharedPrefKeys.showPersonalized) ?? false;

    _lastGenderCategory = prefs.get(SharedPrefKeys.categoryGender) ==
            GenderChoices.men.abbreviation
        ? GenderChoices.men
        : GenderChoices.women;

    emit(SettingsLoaded(showPersonalizedProducts: _showPersonalizedProducts));
  }

  void _onSetShowPersonalizedProducts(
    SetShowPersonalizedProducts event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if user additional is null and user wants recommendations
    if (event.showPersonalizedProducts &&
        _authRepository.user!.userAdditional == null) {
      emit(SettingsErrorUserAdditionalRequired());
    } else {
      prefs.setBool(
        SharedPrefKeys.showPersonalized,
        event.showPersonalizedProducts,
      );
      _showPersonalizedProducts = event.showPersonalizedProducts;

      // Change gender category if user wants recommendations
      if (event.showPersonalizedProducts) {
        final prefs = await SharedPreferences.getInstance();
        final gender =  authRepository.user!.userAdditional!.genderInterested;
        prefs.setString(SharedPrefKeys.categoryGender, gender.abbreviation);
        _lastGenderCategory = gender;
      }
      //TODO: REFACTOR the above and below code to a function

      emit(SettingsLoaded(
          showPersonalizedProducts: event.showPersonalizedProducts));
    }
  }

  void _onSetGenderCategory(SetGenderCategory event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.categoryGender, event.gender.abbreviation);
    _lastGenderCategory = event.gender;
    emit(SettingsLoaded(showPersonalizedProducts: _showPersonalizedProducts));
  }
}
