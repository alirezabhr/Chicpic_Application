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
  late final List<List<Color>> colorsChoices;

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

    final List<List<Color>> tmp = product.variants
        .where((v) => v.coloring.isNotEmpty)
        .map<List<Color>>((v) => v.coloring)
        .toList();

    colorsChoices = removeDuplicates(tmp);
  }
}

class ProductDetailFetchFailure extends ProductsExploreState {}

class ProductSearchLoading extends ProductsExploreState {}

class ProductSearchSuccess extends ProductsExploreState {
  final List<ProductPreview> products;

  ProductSearchSuccess(this.products);
}

class ProductSearchFailure extends ProductsExploreState {}

class SavedVariantsFetchLoading extends ProductsExploreState {}

class SavedVariantsFetchSuccess extends ProductsExploreState {}

class SavedVariantsFetchFailure extends ProductsExploreState {}
