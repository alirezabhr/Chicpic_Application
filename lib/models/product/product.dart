import 'brand.dart';
import 'category.dart';

class ProductBase {
  final int id;
  final Brand brand;
  final String title;
  final String description;
  final Category? category;
  final String imageUrl;
  final String link;
  final double originalPrice;
  final double? finalPrice;

  ProductBase({
    required this.id,
    required this.brand,
    required this.title,
    required this.description,
    this.category,
    required this.imageUrl,
    required this.link,
    required this.originalPrice,
    this.finalPrice,
  });

  factory ProductBase.fromMap(Map<String, dynamic> mapData) {
    final Category? category = mapData['category'] != null
        ? Category.fromMap(mapData['category'])
        : null;

    return ProductBase(
      id: mapData['id'],
      brand: Brand.fromMap(mapData['brand']),
      title: mapData['title'],
      description: mapData['description'],
      category: category,
      imageUrl: mapData['image'],
      link: mapData['link'],
      originalPrice: mapData['originalPrice'].toDouble(),
      finalPrice: mapData['finalPrice']?.toDouble(),
    );
  }
}
