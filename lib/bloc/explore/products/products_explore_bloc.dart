import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/models/product/product.dart';

part 'products_explore_event.dart';
part 'products_explore_state.dart';

class ProductsExploreBloc extends Bloc<ProductsExploreEvent, ProductsExploreState> {
  List<ProductBase> products = [];

  ProductsExploreBloc() : super(ProductsExploreInitial()) {
    on<ProductsExploreFetch>(_onProductsExploreFetch);
  }

  Future<void> _onProductsExploreFetch(
      ProductsExploreFetch event,
      Emitter<ProductsExploreState> emit,
      ) async {
    emit(ProductsExploreFetchLoading());

    try {
      List<ProductBase> data = await APIService.getProducts();
      if (event.page == 0) {
        products = data;
      } else {
        products = products + data;
      }
      emit(ProductsExploreFetchSuccess());
    } catch (_) {
      emit(ProductsExploreFetchFailure());
    }
  }
}
