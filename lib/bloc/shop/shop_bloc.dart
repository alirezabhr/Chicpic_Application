import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/models/pagination.dart';
import 'package:chicpic/models/product/product.dart';
import 'package:chicpic/models/product/shop.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  List<ProductPreview> products = [];
  int page = 1;

  ShopBloc() : super(ShopInitial()) {
    on<ShopProductsFetch>(_onShopProductsFetch);
  }

  Future<void> _onShopProductsFetch(
      ShopProductsFetch event,
      Emitter<ShopState> emit,
      ) async {
    emit(ShopProductsFetchLoading(event.shop));
    if (event.firstPage) {
      page = 1;
      products = [];
    }

    try {
      Pagination<ProductPreview> pagination =
      await APIService.getShopProducts(
        id: event.shop.id,
        page: page,
      );
      products = products + pagination.results;
      page += 1;

      emit(ShopProductsFetchSuccess(
        shop: event.shop,
        products: products,
      ));
    } catch (_) {
      emit(ShopProductsFetchFailure());
    }
  }
}
