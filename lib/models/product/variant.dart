import 'package:equatable/equatable.dart';

import 'package:chicpic/models/product/attribute.dart';

abstract class VariantBase extends Equatable {
  final int id;
  final String imageSrc;
  final String link;
  final double originalPrice;
  final double finalPrice;
  final bool isAvailable;

  const VariantBase({
    required this.id,
    required this.imageSrc,
    required this.link,
    required this.originalPrice,
    required this.finalPrice,
    required this.isAvailable,
  });
}

class VariantPreview extends VariantBase {
  final int product;

  const VariantPreview({
    required super.id,
    required super.imageSrc,
    required super.link,
    required super.originalPrice,
    required super.finalPrice,
    required super.isAvailable,
    required this.product,
  });

  factory VariantPreview.fromMap(Map<String, dynamic> mapData) =>
      VariantPreview(
        id: mapData['id'],
        imageSrc: mapData['imageSrc'],
        link: mapData['link'],
        originalPrice: mapData['originalPrice'],
        finalPrice: mapData['finalPrice'],
        isAvailable: mapData['isAvailable'],
        product: mapData['product'],
      );

  @override
  List<Object?> get props => [
        id,
        imageSrc,
        link,
        originalPrice,
        finalPrice,
        isAvailable,
        product,
      ];
}

class VariantDetail extends VariantBase {
  final List<Attribute> attributes;
  final bool isSaved;
  final bool isTracked;
  final int product;

  const VariantDetail({
    required super.id,
    required super.imageSrc,
    required super.link,
    required super.originalPrice,
    required super.finalPrice,
    required super.isAvailable,
    required this.attributes,
    required this.isSaved,
    required this.isTracked,
    required this.product,
  });

  factory VariantDetail.fromMap(Map<String, dynamic> mapData) => VariantDetail(
        id: mapData['id'],
        imageSrc: mapData['imageSrc'],
        link: mapData['link'],
        originalPrice: mapData['originalPrice'],
        finalPrice: mapData['finalPrice'],
        isAvailable: mapData['isAvailable'],
        attributes: mapData['attributes']
            .map<Attribute>((attrMap) => Attribute.fromMap(attrMap))
            .toList(),
        isSaved: mapData['isSaved'],
        isTracked: mapData['isTracked'],
        product: mapData['product'],
      );

  @override
  List<Object?> get props => [
        id,
        imageSrc,
        link,
        originalPrice,
        finalPrice,
        isAvailable,
        attributes,
        isSaved,
        isTracked,
        product,
      ];
}
