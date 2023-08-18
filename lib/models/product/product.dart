import 'package:equatable/equatable.dart';

import 'package:chicpic/models/product/shop.dart';
import 'package:chicpic/models/product/product_attribute.dart';
import 'package:chicpic/models/product/variant.dart';

abstract class ProductBase extends Equatable {
  final int id;
  final String title;
  final String previewImage;
  final String brand;

  const ProductBase({
    required this.id,
    required this.title,
    required this.previewImage,
    required this.brand,
  });
}

class ProductPreview extends ProductBase {
  final bool hasDiscount;

  const ProductPreview({
    required super.id,
    required super.title,
    required super.previewImage,
    required super.brand,
    required this.hasDiscount,
  });

  factory ProductPreview.fromMap(Map<String, dynamic> mapData) =>
      ProductPreview(
        id: mapData['id'],
        title: mapData['title'],
        previewImage: mapData['previewImage'],
        brand: mapData['brand'],
        hasDiscount: mapData['hasDiscount'],
      );

  @override
  List<Object?> get props => [
        id,
        title,
        previewImage,
        brand,
        hasDiscount,
      ];
}

class ProductDetail extends ProductBase {
  final Shop shop;
  final String description;
  final List<VariantDetail> variants;
  final List<ProductAttribute> attributes;

  const ProductDetail({
    required super.id,
    required super.title,
    required super.brand,
    required super.previewImage,
    required this.description,
    required this.shop,
    required this.variants,
    required this.attributes,
  });

  factory ProductDetail.fromMap(Map<String, dynamic> mapData) => ProductDetail(
        id: mapData['id'],
        title: mapData['title'],
        brand: mapData['brand'],
        description: mapData['description'],
        previewImage: mapData['previewImage'],
        shop: Shop.fromMap(mapData['shop']),
        attributes: mapData['attributes']
            .map<ProductAttribute>(
                (attributeMap) => ProductAttribute.fromMap(attributeMap))
            .toList(),
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
        attributes,
      ];
}
