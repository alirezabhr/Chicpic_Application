part of 'products_explore_bloc.dart';

@immutable
abstract class ProductsExploreEvent {}

class ProductsExploreFetch extends ProductsExploreEvent {
  final bool firstPage;

  ProductsExploreFetch({this.firstPage=true});
}

class ProductDetailFetch extends ProductsExploreEvent {
  final int productId;
  final int? variantId;

  ProductDetailFetch(this.productId, this.variantId);
}
