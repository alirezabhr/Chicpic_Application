import 'package:bloc/bloc.dart';
import 'package:chicpic/models/pagination.dart';
import 'package:chicpic/models/product/category.dart';
import 'package:chicpic/services/api_service.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/models/product/product.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<ProductPreview> products = [];
  int page = 1;

  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryProductsFetch>(_onCategoryProductsFetch);
  }

  Future<void> _onCategoryProductsFetch(
    CategoryProductsFetch event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryProductsFetchLoading(event.category));
    if (event.firstPage) {
      page = 1;
      products = [];
    }

    try {
      Pagination<ProductPreview> pagination =
          await APIService.getCategoryProducts(
        id: event.category.id,
        page: page,
      );
      products = products + pagination.results;
      page += 1;

      emit(CategoryProductsFetchSuccess(
        category: event.category,
        products: products,
      ));
    } catch (_) {
      emit(CategoryProductsFetchFailure());
    }
  }
}
