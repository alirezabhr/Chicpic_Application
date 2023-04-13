part of 'shops_explore_bloc.dart';

@immutable
abstract class ShopsExploreEvent {}

class ShopsExploreFetch extends ShopsExploreEvent {
  final bool firstPage;

  ShopsExploreFetch({this.firstPage=true});
}
