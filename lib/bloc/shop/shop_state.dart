part of 'shop_bloc.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopVariantsFetchLoading extends ShopState {
  final Shop shop;
  final bool firstPage;

  ShopVariantsFetchLoading(this.shop, this.firstPage);
}

class ShopVariantsFetchSuccess extends ShopState {
  final Shop shop;
  final List<VariantPreview> variants;

  ShopVariantsFetchSuccess({
    required this.shop,
    required this.variants,
  });
}

class ShopVariantsFetchFailure extends ShopState {}
