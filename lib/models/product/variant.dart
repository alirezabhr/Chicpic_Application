import 'package:equatable/equatable.dart';

abstract class VariantBase extends Equatable {
  final int id;
  final String imageSrc;
  final String link;
  final double originalPrice;
  final double finalPrice;
  final bool isAvailable;
  final String? option1;
  final String? option2;
  final String? option3;
  final int product;

  const VariantBase({
    required this.id,
    required this.imageSrc,
    required this.link,
    required this.originalPrice,
    required this.finalPrice,
    required this.isAvailable,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.product,
  });
}

class VariantPreview extends VariantBase {
  const VariantPreview({
    required super.id,
    required super.imageSrc,
    required super.link,
    required super.originalPrice,
    required super.finalPrice,
    required super.isAvailable,
    required super.option1,
    required super.option2,
    required super.option3,
    required super.product,
  });

  factory VariantPreview.fromMap(Map<String, dynamic> mapData) =>
      VariantPreview(
        id: mapData['id'],
        imageSrc: mapData['imageSrc'],
        link: mapData['link'],
        originalPrice: mapData['originalPrice'],
        finalPrice: mapData['finalPrice'],
        isAvailable: mapData['isAvailable'],
        option1: mapData['option1'],
        option2: mapData['option2'],
        option3: mapData['option3'],
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
        option1,
        option2,
        option3,
      ];
}

class VariantDetail extends VariantBase {
  final bool isSaved;
  final bool isTracked;

  const VariantDetail({
    required super.id,
    required super.imageSrc,
    required super.link,
    required super.originalPrice,
    required super.finalPrice,
    required super.isAvailable,
    required super.product,
    required super.option1,
    required super.option2,
    required super.option3,
    required this.isSaved,
    required this.isTracked,
  });

  factory VariantDetail.fromMap(Map<String, dynamic> mapData) => VariantDetail(
        id: mapData['id'],
        imageSrc: mapData['imageSrc'],
        link: mapData['link'],
        originalPrice: mapData['originalPrice'],
        finalPrice: mapData['finalPrice'],
        isAvailable: mapData['isAvailable'],
        product: mapData['product'],
        option1: mapData['option1'],
        option2: mapData['option2'],
        option3: mapData['option3'],
        isSaved: mapData['isSaved'],
        isTracked: mapData['isTracked'],
      );

  @override
  List<Object?> get props => [
        id,
        imageSrc,
        link,
        originalPrice,
        finalPrice,
        isAvailable,
        option1,
        option2,
        option3,
        isSaved,
        isTracked,
        product,
      ];
}
