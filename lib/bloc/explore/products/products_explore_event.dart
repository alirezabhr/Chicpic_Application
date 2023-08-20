part of 'products_explore_bloc.dart';

@immutable
abstract class ProductsExploreEvent {}

class ProductsExploreFetch extends ProductsExploreEvent {
  final bool firstPage;

  ProductsExploreFetch({this.firstPage = true});
}

class SavedVariantsFetch extends ProductsExploreEvent {
  final bool firstPage;

  SavedVariantsFetch({this.firstPage = true});
}

class ProductDetailFetch extends ProductsExploreEvent {
  final int productId;
  final int? variantId;

  ProductDetailFetch(this.productId, this.variantId);
}

class ProductDetailChangeColor extends ProductsExploreEvent {
  final ProductDetail product;
  final List<Color> coloring;

  ProductDetailChangeColor(this.product, this.coloring);
}

class ProductDetailChangeSize extends ProductsExploreEvent {
  final ProductDetail product;
  final String selectedColorHex;
  final String selectedSize;

  ProductDetailChangeSize(
    this.product,
    this.selectedColorHex,
    this.selectedSize,
  );
}

class VariantTrackToggle extends ProductsExploreEvent {
  final ProductDetail product;
  final VariantDetail selectedVariant;

  VariantTrackToggle({
    required this.product,
    required this.selectedVariant,
  });
}

class VariantSaveToggle extends ProductsExploreEvent {
  final ProductDetail product;
  final VariantDetail selectedVariant;

  VariantSaveToggle({
    required this.product,
    required this.selectedVariant,
  });
}

class ProductSearch extends ProductsExploreEvent {
  final String searchText;
  final bool firstPage;

  ProductSearch(this.searchText, {this.firstPage = true});
}
