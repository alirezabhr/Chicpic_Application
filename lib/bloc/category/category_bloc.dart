import 'package:bloc/bloc.dart';
import 'package:chicpic/models/auth/gender_choices.dart';
import 'package:chicpic/models/pagination.dart';
import 'package:chicpic/models/product/category.dart';
import 'package:chicpic/models/product/variant.dart';
import 'package:chicpic/repositories/auth/auth_repository.dart';
import 'package:chicpic/repositories/settings/settings_repository.dart';
import 'package:chicpic/services/api_service.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final AuthRepository _authRepository;
  final SettingsRepository _settingsRepository;
  List<VariantPreview> variants = [];
  int page = 1;

  CategoryBloc(this._authRepository, this._settingsRepository)
      : super(CategoryInitial()) {
    on<CategoryVariantsFetch>(_onCategoryVariantsFetch);
    on<DiscountedVariantsFetch>(_onDiscountedVariantsFetch);
  }

  Future<void> _onCategoryVariantsFetch(
    CategoryVariantsFetch event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryVariantsFetchLoading(event.category, event.firstPage));
    if (event.firstPage) {
      page = 1;
      variants = [];
    }

    // Remind user to add additional info
    if (await _authRepository.shouldRemindUserAdditional()) {
      emit(CategoryVariantsFetchRemindUserAdditional());
    }

    try {
      Pagination<VariantPreview> pagination =
          await APIService.getCategoryVariants(
        id: event.category.id,
        shouldRecommend: _settingsRepository.showPersonalizedProducts,
        page: page,
      );
      variants = variants + pagination.results;
      page += 1;

      emit(CategoryVariantsFetchSuccess(
        category: event.category,
        variants: variants,
      ));
    } catch (_) {
      emit(CategoryVariantsFetchFailure());
    }
  }

  Future<void> _onDiscountedVariantsFetch(
    DiscountedVariantsFetch event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryVariantsFetchLoading(event.category, event.firstPage));
    if (event.firstPage) {
      page = 1;
      variants = [];
    }

    // Remind user to add additional info
    if (await _authRepository.shouldRemindUserAdditional()) {
      emit(CategoryVariantsFetchRemindUserAdditional());
    }

    try {
      Pagination<VariantPreview> pagination =
          await APIService.getDiscountedVariants(
        discount: event.discount,
        genderChoices: event.gender,
        shouldRecommend: _settingsRepository.showPersonalizedProducts,
        page: page,
      );
      variants = variants + pagination.results;
      page += 1;

      emit(CategoryVariantsFetchSuccess(
        category: event.category,
        variants: variants,
      ));
    } catch (_) {
      emit(CategoryVariantsFetchFailure());
    }
  }
}
