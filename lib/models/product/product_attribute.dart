import 'package:equatable/equatable.dart';

class ProductAttribute extends Equatable {
  final int id;
  final int position;
  final String name;
  final List<dynamic> values;

  const ProductAttribute({
    required this.id,
    required this.position,
    required this.name,
    required this.values,
  });

  factory ProductAttribute.fromMap(Map<String, dynamic> mapData) =>
      ProductAttribute(
        id: mapData['id'],
        position: mapData['position'],
        name: mapData['name'],
        values: mapData['values'],
      );

  @override
  List<Object?> get props => [id, position, name, values];
}
