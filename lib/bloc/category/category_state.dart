part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryProductsFetchLoading extends CategoryState {
  final Category category;

  CategoryProductsFetchLoading(this.category);
}

class CategoryProductsFetchSuccess extends CategoryState {
  final Category category;
  final List<ProductPreview> products;

  CategoryProductsFetchSuccess({
    required this.category,
    required this.products,
  });
}

class CategoryProductsFetchFailure extends CategoryState {}
