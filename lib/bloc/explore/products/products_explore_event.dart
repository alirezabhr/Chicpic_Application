part of 'products_explore_bloc.dart';

@immutable
abstract class ProductsExploreEvent {}

class ProductsExploreFetch extends ProductsExploreEvent {
  final bool firstPage;

  ProductsExploreFetch({this.firstPage=true});
}
