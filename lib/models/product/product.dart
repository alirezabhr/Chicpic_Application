import 'package:equatable/equatable.dart';

import 'package:chicpic/models/product/shop.dart';
import 'package:chicpic/models/product/variant.dart';

abstract class ProductBase extends Equatable {
  final int id;
  final String title;
  final String brand;
  final String description;
  final String previewImage;

  const ProductBase({
    required this.id,
    required this.title,
    required this.brand,
    required this.description,
    required this.previewImage,
  });
}

class ProductPreview extends ProductBase {
  final int shop;
  final int category;

  const ProductPreview({
    required super.id,
    required super.title,
    required super.brand,
    required super.description,
    required super.previewImage,
    required this.shop,
    required this.category,
  });

  factory ProductPreview.fromMap(Map<String, dynamic> mapData) =>
      ProductPreview(
        id: mapData['id'],
        title: mapData['title'],
        brand: mapData['brand'],
        description: mapData['description'],
        previewImage: mapData['previewImage'],
        shop: mapData['shop'],
        category: mapData['category'],
      );

  @override
  List<Object?> get props => [
        id,
        title,
        brand,
        description,
        previewImage,
        shop,
        category,
      ];
}

class ProductDetail extends ProductBase {
  final Shop shop;
  final List<VariantDetail> variants;

  const ProductDetail({
    required super.id,
    required super.title,
    required super.brand,
    required super.description,
    required super.previewImage,
    required this.shop,
    required this.variants,
  });

  factory ProductDetail.fromMap(Map<String, dynamic> mapData) => ProductDetail(
        id: mapData['id'],
        title: mapData['title'],
        brand: mapData['brand'],
        description: mapData['description'],
        previewImage: mapData['previewImage'],
        shop: Shop.fromMap(mapData['shop']),
        variants: mapData['variants']
            .map<VariantDetail>(
                (variantMap) => VariantDetail.fromMap(variantMap))
            .toList(),
      );

  @override
  List<Object?> get props => [
        id,
        title,
        brand,
        description,
        previewImage,
        shop,
        variants,
      ];
}
