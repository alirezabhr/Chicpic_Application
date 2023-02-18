import 'product.dart';
import 'shop.dart';
import 'category.dart';

class ProductSavedTracked extends ProductBase {
  final bool isSaved;
  final bool isTracked;

  ProductSavedTracked({
    required super.id,
    required super.shop,
    required super.title,
    required super.description,
    super.category,
    required super.imageUrl,
    required super.link,
    required super.originalPrice,
    super.finalPrice,
    required this.isSaved,
    required this.isTracked,
  });

  factory ProductSavedTracked.fromMap(Map<String, dynamic> mapData) {
    final Category? category = mapData['category'] != null
        ? Category.fromMap(mapData['category'])
        : null;

    return ProductSavedTracked(
      id: mapData['id'],
      shop: Shop.fromMap(mapData['shop']),
      title: mapData['title'],
      description: mapData['description'],
      category: category,
      imageUrl: mapData['image'],
      link: mapData['link'],
      originalPrice: mapData['originalPrice'].toDouble(),
      finalPrice: mapData['finalPrice']?.toDouble(),
      isSaved: mapData['isSaved'],
      isTracked: mapData['isTracked'],
    );
  }
}
