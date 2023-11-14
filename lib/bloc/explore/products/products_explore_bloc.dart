import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/repositories/auth/auth_repository.dart';

import 'package:chicpic/services/api_service.dart';
import 'package:chicpic/services/utils.dart';

import 'package:chicpic/models/pagination.dart';
import 'package:chicpic/models/product/product.dart';
import 'package:chicpic/models/product/variant.dart';

part 'products_explore_event.dart';

part 'products_explore_state.dart';

class ProductsExploreBloc
    extends Bloc<ProductsExploreEvent, ProductsExploreState> {
  final AuthRepository _authRepository;

  List<VariantPreview> variants = [];
  List<ProductPreview> searchedProducts = [];
  List<VariantPreview> savedVariants = [];
  int explorePage = 1;
  int searchPage = 1;
  int savedVariantsPage = 1;

  ProductsExploreBloc(this._authRepository) : super(ProductsExploreInitial()) {
    on<ProductsExploreFetch>(_onProductsExploreFetch);
    on<ProductDetailFetch>(_onProductDetailFetch);
    on<ProductDetailChangeColor>(_onProductDetailChangeColor);
    on<ProductDetailChangeSize>(_onProductDetailChangeSize);
    on<VariantTrackToggle>(_onVariantTrackToggle);
    on<VariantSaveToggle>(_onVariantSaveToggle);
    on<ProductSearch>(_onProductSearch);
    on<SavedVariantsFetch>(_onSavedVariantsFetch);
  }

  Future<void> _onProductsExploreFetch(
    ProductsExploreFetch event,
    Emitter<ProductsExploreState> emit,
  ) async {
    if (event.firstPage) {
      explorePage = 1;
      variants = [];
    }
    emit(
      ProductsExploreFetchLoading(
          page: explorePage, firstPage: event.firstPage),
    );

    // Remind user to add additional info
    if (await _authRepository.shouldRemindUserAdditional()) {
      emit(ProductsExploreFetchRemindUserAdditional());
    }

    try {
      Pagination<VariantPreview> pagination =
          await APIService.exploreVariants(page: explorePage);
      variants = variants + pagination.results;
      explorePage += 1;
      emit(ProductsExploreFetchSuccess());
    } catch (_) {
      emit(ProductsExploreFetchFailure());
    }
  }

  Future<void> _onProductDetailFetch(
    ProductDetailFetch event,
    Emitter<ProductsExploreState> emit,
  ) async {
    emit(ProductDetailFetchLoading());

    try {
      ProductDetail product = await APIService.getProduct(event.productId);
      emit(ProductDetailFetchSuccess(
        product: product,
        selectedVariantId: event.variantId,
      ));
    } catch (_) {
      emit(ProductDetailFetchFailure());
    }
  }

  void _onProductDetailChangeColor(
    ProductDetailChangeColor event,
    Emitter<ProductsExploreState> emit,
  ) {
    final selectedVariant = event.product.variants.firstWhere(
      (v) => v.coloring == event.coloring,
      orElse: () => event.product.variants.first,
    );
    emit(ProductDetailFetchSuccess(
      product: event.product,
      selectedVariantId: selectedVariant.id,
    ));
  }

  void _onProductDetailChangeSize(
    ProductDetailChangeSize event,
    Emitter<ProductsExploreState> emit,
  ) {
    final selectedVariant = event.product.variants.firstWhere(
      (VariantDetail v) =>
          v.colorHex == event.selectedColorHex && v.size == event.selectedSize,
      orElse: () => event.product.variants.first,
    );

    emit(ProductDetailFetchSuccess(
      product: event.product,
      selectedVariantId: selectedVariant.id,
    ));
  }

  Future<void> _onVariantTrackToggle(
    VariantTrackToggle event,
    Emitter<ProductsExploreState> emit,
  ) async {
    try {
      final userId = _authRepository.user?.id;
      final int index = event.product.variants.indexOf(event.selectedVariant);

      if (event.selectedVariant.isTracked) {
        // Untrack the variant
        await APIService.untrackVariant(userId!, event.selectedVariant.id);
      } else {
        // Track the variant
        await APIService.trackVariant(userId!, event.selectedVariant.id);
      }

      event.product.variants[index] = event.product.variants[index]
          .copyWith(isTracked: !event.selectedVariant.isTracked);

      emit(VariantTrackToggleSuccess(
        product: event.product,
        selectedVariantId: event.selectedVariant.id,
      ));
    } catch (e) {
      emit(VariantTrackToggleFailure());
      emit(ProductDetailFetchSuccess(
        product: event.product,
        selectedVariantId: event.selectedVariant.id,
      ));
    }
  }

  Future<void> _onVariantSaveToggle(
    VariantSaveToggle event,
    Emitter<ProductsExploreState> emit,
  ) async {
    try {
      final userId = _authRepository.user?.id;
      final int index = event.product.variants.indexOf(event.selectedVariant);

      if (event.selectedVariant.isSaved) {
        // Unsave the variant
        await APIService.unsaveVariant(userId!, event.selectedVariant.id);
      } else {
        // Save the variant
        await APIService.saveVariant(userId!, event.selectedVariant.id);
      }

      event.product.variants[index] = event.product.variants[index]
          .copyWith(isSaved: !event.selectedVariant.isSaved);

      emit(VariantSaveToggleSuccess(
        product: event.product,
        selectedVariantId: event.selectedVariant.id,
      ));
    } catch (e) {
      emit(VariantSaveToggleFailure());
      emit(ProductDetailFetchSuccess(
        product: event.product,
        selectedVariantId: event.selectedVariant.id,
      ));
    }
  }

  Future<void> _onProductSearch(
    ProductSearch event,
    Emitter<ProductsExploreState> emit,
  ) async {
    emit(ProductSearchLoading(event.firstPage));

    if (event.firstPage) {
      searchPage = 1;
      searchedProducts = [];
    }

    try {
      final pagination = await APIService.searchProduct(
        searchText: event.searchText,
        page: searchPage,
      );

      searchPage += 1;
      searchedProducts += pagination.results;
      emit(ProductSearchSuccess(searchedProducts));
    } catch (_) {
      emit(ProductSearchFailure());
    }
  }

  Future<void> _onSavedVariantsFetch(
    SavedVariantsFetch event,
    Emitter<ProductsExploreState> emit,
  ) async {
    if (event.firstPage) {
      savedVariantsPage = 1;
      savedVariants = [];
    }
    emit(
      ProductsExploreFetchLoading(
          page: savedVariantsPage, firstPage: event.firstPage),
    );

    try {
      final userId = _authRepository.user?.id;
      Pagination<VariantPreview> pagination =
          await APIService.retrieveSavedVariants(userId!,
              page: savedVariantsPage);
      savedVariants = savedVariants + pagination.results;
      savedVariantsPage += 1;
      emit(ProductsExploreFetchSuccess());
    } catch (_) {
      emit(ProductsExploreFetchFailure());
    }
  }
}
