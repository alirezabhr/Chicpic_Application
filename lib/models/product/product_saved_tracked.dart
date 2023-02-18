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
    required super.brand,
    required super.description,
    super.category,
    required super.image,
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
      brand: mapData['brand'],
      description: mapData['description'],
      category: category,
      image: mapData['image'],
      link: mapData['link'],
      originalPrice: double.parse(mapData['originalPrice']),
      finalPrice: double.tryParse(mapData['finalPrice'] ?? ''),
      isSaved: mapData['isSaved'],
      isTracked: mapData['isTracked'],
    );
  }
}
