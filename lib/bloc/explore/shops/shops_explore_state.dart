part of 'shops_explore_bloc.dart';

@immutable
abstract class ShopsExploreState {}

class ShopsExploreInitial extends ShopsExploreState {}

class ShopsExploreFetchLoading extends ShopsExploreState {}

class ShopsExploreFetchSuccess extends ShopsExploreState {}

class ShopsExploreFetchFailure extends ShopsExploreState {}
