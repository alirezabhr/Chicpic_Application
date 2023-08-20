import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'package:chicpic/services/utils.dart';

abstract class VariantBase extends Equatable {
  final int id;
  final String imageSrc;
  final String link;
  final double originalPrice;
  final double finalPrice;
  final bool isAvailable;
  final String? size;
  final String? option1;
  final String? option2;
  final String? colorHex;
  final int product;
  final List<Color> coloring;

  const VariantBase({
    required this.id,
    required this.imageSrc,
    required this.link,
    required this.originalPrice,
    required this.finalPrice,
    required this.isAvailable,
    required this.size,
    required this.option1,
    required this.option2,
    required this.colorHex,
    required this.coloring,
    required this.product,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'imageSrc': imageSrc,
        'link': link,
        'originalPrice': originalPrice,
        'finalPrice': finalPrice,
        'isAvailable': isAvailable,
        'size': size,
        'option1': option1,
        'option2': option2,
        'colorHex': colorHex,
        'product': product,
      };
}

class VariantPreview extends VariantBase {
  final bool hasDiscount;

  const VariantPreview({
    required super.id,
    required super.imageSrc,
    required super.link,
    required super.originalPrice,
    required super.finalPrice,
    required super.isAvailable,
    required super.size,
    required super.option1,
    required super.option2,
    required super.colorHex,
    required super.coloring,
    required super.product,
    required this.hasDiscount,
  });

  factory VariantPreview.fromMap(Map<String, dynamic> mapData) {
    List<String> colorsHex = [];
    if (mapData['colorHex'] != null) {
      colorsHex = mapData['colorHex'].split('/');
    }

    if (mapData['hasDiscount'] == null) {
      print(mapData);
    }

    return VariantPreview(
      id: mapData['id'],
      imageSrc: mapData['imageSrc'],
      link: mapData['link'],
      originalPrice: mapData['originalPrice'],
      finalPrice: mapData['finalPrice'],
      isAvailable: mapData['isAvailable'],
      size: mapData['size'],
      option1: mapData['option1'],
      option2: mapData['option2'],
      colorHex: mapData['colorHex'],
      coloring: colorsHex
          .map<Color>((colorCode) => Color(strToHex(colorCode)))
          .toList(),
      product: mapData['product'],
      hasDiscount: mapData['hasDiscount'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        imageSrc,
        link,
        originalPrice,
        finalPrice,
        isAvailable,
        product,
        size,
        option1,
        option2,
        colorHex,
        coloring,
        hasDiscount,
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
    required super.size,
    required super.option1,
    required super.option2,
    required super.colorHex,
    required super.coloring,
    required this.isSaved,
    required this.isTracked,
  });

  factory VariantDetail.fromMap(Map<String, dynamic> mapData) {
    List<String> colorsHex = [];
    if (mapData['colorHex'] != null) {
      colorsHex = mapData['colorHex'].split('/');
    }

    return VariantDetail(
      id: mapData['id'],
      imageSrc: mapData['imageSrc'],
      link: mapData['link'],
      originalPrice: mapData['originalPrice'],
      finalPrice: mapData['finalPrice'],
      isAvailable: mapData['isAvailable'],
      product: mapData['product'],
      size: mapData['size'],
      option1: mapData['option1'],
      option2: mapData['option2'],
      colorHex: mapData['colorHex'],
      coloring: colorsHex
          .map<Color>((colorCode) => Color(strToHex(colorCode)))
          .toList(),
      isSaved: mapData['isSaved'],
      isTracked: mapData['isTracked'],
    );
  }

  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..addAll({
      'isSaved': isSaved,
      'isTracked': isTracked,
    });

  VariantDetail copyWith({
    int? id,
    String? imageSrc,
    String? link,
    double? originalPrice,
    double? finalPrice,
    bool? isAvailable,
    int? product,
    String? size,
    String? option1,
    String? option2,
    String? colorHex,
    List<Color>? coloring,
    bool? isSaved,
    bool? isTracked,
  }) =>
      VariantDetail(
        id: id ?? this.id,
        imageSrc: imageSrc ?? this.imageSrc,
        link: link ?? this.link,
        originalPrice: originalPrice ?? this.originalPrice,
        finalPrice: finalPrice ?? this.finalPrice,
        isAvailable: isAvailable ?? this.isAvailable,
        product: product ?? this.product,
        size: size ?? this.size,
        option1: option1 ?? this.option1,
        option2: option2 ?? this.option2,
        colorHex: colorHex ?? this.colorHex,
        coloring: coloring ?? this.coloring,
        isSaved: isSaved ?? this.isSaved,
        isTracked: isTracked ?? this.isTracked,
      );

  @override
  List<Object?> get props => [
        id,
        imageSrc,
        link,
        originalPrice,
        finalPrice,
        isAvailable,
        size,
        option1,
        option2,
        colorHex,
        coloring,
        isSaved,
        isTracked,
        product,
      ];
}
