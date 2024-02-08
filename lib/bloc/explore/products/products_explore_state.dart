part of 'products_explore_bloc.dart';

@immutable
abstract class ProductsExploreState {}

class ProductsExploreInitial extends ProductsExploreState {}

class ProductsExploreFetchRemindUserAdditional extends ProductsExploreState {}

class ProductsExploreFetchLoading extends ProductsExploreState {
  final int page;
  final bool firstPage;

  ProductsExploreFetchLoading({required this.page, required this.firstPage});
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

class VariantSearchLoading extends ProductsExploreState {
  final bool firstPage;

  VariantSearchLoading(this.firstPage);
}

class VariantSearchSuccess extends ProductsExploreState {}

class VariantSearchFailure extends ProductsExploreState {}

class SavedVariantsFetchLoading extends ProductsExploreState {}

class SavedVariantsFetchSuccess extends ProductsExploreState {}

class SavedVariantsFetchFailure extends ProductsExploreState {}

class VariantTrackToggleSuccess extends ProductDetailFetchSuccess {
  VariantTrackToggleSuccess({
    required super.product,
    required super.selectedVariantId,
  });
}

class VariantTrackToggleFailure extends ProductDetailFetchFailure {}

class VariantSaveToggleSuccess extends ProductDetailFetchSuccess {
  VariantSaveToggleSuccess({
    required super.product,
    required super.selectedVariantId,
  });
}

class VariantSaveToggleFailure extends ProductDetailFetchFailure {}
