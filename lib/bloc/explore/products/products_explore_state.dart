part of 'products_explore_bloc.dart';

@immutable
abstract class ProductsExploreState {}

class ProductsExploreInitial extends ProductsExploreState {}

class ProductsExploreFetchLoading extends ProductsExploreState {}

class ProductsExploreFetchSuccess extends ProductsExploreState {}

class ProductsExploreFetchFailure extends ProductsExploreState {}
