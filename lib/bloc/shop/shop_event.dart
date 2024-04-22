part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}

class ShopVariantsFetch extends ShopEvent {
  final Shop shop;
  final bool firstPage;

  ShopVariantsFetch(this.shop, {this.firstPage=true});
}