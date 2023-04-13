import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/models/pagination.dart';
import 'package:chicpic/models/product/variant.dart';

part 'products_explore_event.dart';

part 'products_explore_state.dart';

class ProductsExploreBloc
    extends Bloc<ProductsExploreEvent, ProductsExploreState> {
  List<VariantPreview> variants = [];
  int page = 1;

  ProductsExploreBloc() : super(ProductsExploreInitial()) {
    on<ProductsExploreFetch>(_onProductsExploreFetch);
  }

  Future<void> _onProductsExploreFetch(
    ProductsExploreFetch event,
    Emitter<ProductsExploreState> emit,
  ) async {
    emit(ProductsExploreFetchLoading());

    try {
      if (event.firstPage) {
        page = 1;
        variants = [];
      }
      Pagination<VariantPreview> pagination = await APIService.getVariants();
      variants = variants + pagination.results;
      page += 1;
      emit(ProductsExploreFetchSuccess());
    } catch (_) {
      emit(ProductsExploreFetchFailure());
    }
  }
}
