import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/models/pagination.dart';
import 'package:chicpic/models/product/shop.dart';

part 'shops_explore_event.dart';

part 'shops_explore_state.dart';

class ShopsExploreBloc extends Bloc<ShopsExploreEvent, ShopsExploreState> {
  List<Shop> shops = [];
  int page = 1;

  ShopsExploreBloc() : super(ShopsExploreInitial()) {
    on<ShopsExploreFetch>(_onShopsExploreFetch);
  }

  Future<void> _onShopsExploreFetch(
    ShopsExploreFetch event,
    Emitter<ShopsExploreState> emit,
  ) async {
    emit(ShopsExploreFetchLoading());

    try {
      if (event.firstPage) {
        page = 1;
        shops = [];
      }
      Pagination<Shop> pagination = await APIService.getShops(page: page);
      shops = shops + pagination.results;
      page += 1;
      emit(ShopsExploreFetchSuccess());
    } catch (_) {
      emit(ShopsExploreFetchFailure());
    }
  }
}
