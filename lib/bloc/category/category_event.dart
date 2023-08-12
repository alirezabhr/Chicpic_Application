part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategoryProductsFetch extends CategoryEvent {
  final Category category;
  final bool firstPage;

  CategoryProductsFetch(this.category, {this.firstPage=true});
}

class DiscountedProductsFetch extends CategoryEvent {
  final Category category;
  final int discount;
  final bool firstPage;

  DiscountedProductsFetch(this.category, this.discount, {this.firstPage=true});
}
