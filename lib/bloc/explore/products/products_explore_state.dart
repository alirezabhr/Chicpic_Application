part of 'products_explore_bloc.dart';

@immutable
abstract class ProductsExploreState {}

class ProductsExploreInitial extends ProductsExploreState {}

class ProductsExploreFetchLoading extends ProductsExploreState {
  final int page;

  ProductsExploreFetchLoading({required this.page});
}

class ProductsExploreFetchSuccess extends ProductsExploreState {}

class ProductsExploreFetchFailure extends ProductsExploreState {}

class ProductDetailFetchLoading extends ProductsExploreState {}

class ProductDetailFetchSuccess extends ProductsExploreState {
  final ProductDetail product;
  late final VariantDetail selectedVariant;

  ProductDetailFetchSuccess({
    required this.product,
    required int? selectedVariantId,
  }) {
    if (selectedVariantId == null) {
      selectedVariant = product.variants.first;
    } else {
      selectedVariant = product.variants
          .firstWhere((element) => element.id == selectedVariantId);
    }
  }
}

class ProductDetailFetchFailure extends ProductsExploreState {}
