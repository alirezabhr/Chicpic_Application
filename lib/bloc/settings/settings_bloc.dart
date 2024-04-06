import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:chicpic/repositories/auth/auth_repository.dart';
import 'package:chicpic/repositories/settings/settings_repository.dart';
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
    await _settingsRepo.loadConfigs();
    emit(SettingsLoaded());
  }

  void _onUpdateShowPersonalizedProducts(
    UpdateShowPersonalizedProducts event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());

    // Check if user additional is null and user wants recommendations
    if (event.showPersonalizedProducts &&
        _authRepo.user!.userAdditional == null) {
      emit(SettingsErrorUserAdditionalRequired());
    } else {
      _settingsRepo.setPersonalizedProducts(event.showPersonalizedProducts);

      // Change gender category if user wants recommendations
      if (event.showPersonalizedProducts) {
        final gender = _authRepo.user!.userAdditional!.genderInterested;
        await _settingsRepo.setGenderCategory(gender);
      }

      emit(SettingsShowPersonalizedProductsUpdated());
    }
  }

  void _onUpdateGenderCategory(
    UpdateGenderCategory event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    await _settingsRepo.setGenderCategory(event.gender);
    emit(SettingsLoaded());
  }
}
