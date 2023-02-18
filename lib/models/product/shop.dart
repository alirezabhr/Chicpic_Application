class Shop {
  final int id;
  final String name;
  final String image;
  final DateTime createdAt;

  Shop({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
  });

  factory Shop.fromMap(Map<String, dynamic> mapData) {
    return Shop(
      id: mapData['id'],
      name: mapData['name'],
      image: mapData['image'],
      createdAt: DateTime.parse(mapData['createdAt']),
    );
  }
}