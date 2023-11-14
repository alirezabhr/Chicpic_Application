part of 'shop_bloc.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopProductsFetchLoading extends ShopState {
  final Shop shop;
  final bool firstPage;

  ShopProductsFetchLoading(this.shop, this.firstPage);
}

class ShopProductsFetchSuccess extends ShopState {
  final Shop shop;
  final List<ProductPreview> products;

  ShopProductsFetchSuccess({
    required this.shop,
    required this.products,
  });
}

class ShopProductsFetchFailure extends ShopState {}
