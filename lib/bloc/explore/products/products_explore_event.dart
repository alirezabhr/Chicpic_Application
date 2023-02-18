part of 'products_explore_bloc.dart';

@immutable
abstract class ProductsExploreEvent {}

class ProductsExploreFetch extends ProductsExploreEvent {
  final int page;

  ProductsExploreFetch({this.page=0});
}
