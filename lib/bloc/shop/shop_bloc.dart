import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/repositories/settings/settings_repository.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/models/pagination.dart';
import 'package:chicpic/models/product/variant.dart';
import 'package:chicpic/models/product/shop.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final SettingsRepository _settingsRepository;
  List<VariantPreview> variants = [];
  int page = 1;

  ShopBloc(this._settingsRepository) : super(ShopInitial()) {
    on<ShopVariantsFetch>(_onShopVariantsFetch);
  }

  Future<void> _onShopVariantsFetch(
      ShopVariantsFetch event,
      Emitter<ShopState> emit,
      ) async {
    emit(ShopVariantsFetchLoading(event.shop, event.firstPage));
    if (event.firstPage) {
      page = 1;
      variants = [];
    }

    try {
      Pagination<VariantPreview> pagination =
      await APIService.getShopVariants(
        id: event.shop.id,
        shouldRecommend: _settingsRepository.showPersonalizedProducts,
        page: page,
      );
      variants = variants + pagination.results;
      page += 1;

      emit(ShopVariantsFetchSuccess(
        shop: event.shop,
        variants: variants,
      ));
    } catch (_) {
      emit(ShopVariantsFetchFailure());
    }
  }
}
