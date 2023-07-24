import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/services/api_service.dart';
import 'package:chicpic/services/utils.dart';

import 'package:chicpic/models/pagination.dart';
import 'package:chicpic/models/product/product.dart';
import 'package:chicpic/models/product/variant.dart';

part 'products_explore_event.dart';

part 'products_explore_state.dart';

class ProductsExploreBloc
    extends Bloc<ProductsExploreEvent, ProductsExploreState> {
  List<VariantPreview> variants = [];
  List<ProductPreview> searchedProducts = [];
  int explorePage = 1;
  int searchPage = 1;

  ProductsExploreBloc() : super(ProductsExploreInitial()) {
    on<ProductsExploreFetch>(_onProductsExploreFetch);
    on<ProductDetailFetch>(_onProductDetailFetch);
    on<ProductDetailChangeColor>(_onProductDetailChangeColor);
    on<ProductDetailChangeSize>(_onProductDetailChangeSize);
    on<ProductSearch>(_onProductSearch);
  }

  Future<void> _onProductsExploreFetch(
    ProductsExploreFetch event,
    Emitter<ProductsExploreState> emit,
  ) async {
    if (event.firstPage) {
      explorePage = 1;
      variants = [];
    }
    emit(ProductsExploreFetchLoading(page: explorePage));

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

  Future<void> _onProductSearch(
    ProductSearch event,
    Emitter<ProductsExploreState> emit,
  ) async {
    emit(ProductSearchLoading());

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
}
