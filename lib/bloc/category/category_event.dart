part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategoryVariantsFetch extends CategoryEvent {
  final Category category;
  final bool firstPage;

  CategoryVariantsFetch(this.category, {this.firstPage = true});
}

class DiscountedVariantsFetch extends CategoryEvent {
  final Category category;
  final int discount;
  final GenderChoices gender;
  final bool firstPage;

  DiscountedVariantsFetch(this.category, this.discount, this.gender,
      {this.firstPage = true});
}
