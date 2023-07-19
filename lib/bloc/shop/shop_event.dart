part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}

class ShopProductsFetch extends ShopEvent {
  final Shop shop;
  final bool firstPage;

  ShopProductsFetch(this.shop, {this.firstPage=true});
}