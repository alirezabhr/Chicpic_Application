part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryVariantsFetchLoading extends CategoryState {
  final Category category;

  CategoryVariantsFetchLoading(this.category);
}

class CategoryVariantsFetchSuccess extends CategoryState {
  final Category category;
  final List<VariantPreview> variants;

  CategoryVariantsFetchSuccess({
    required this.category,
    required this.variants,
  });
}

class CategoryVariantsFetchFailure extends CategoryState {}
