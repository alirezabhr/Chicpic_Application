class Brand {
  final int id;
  final String name;
  final DateTime createdAt;

  Brand({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory Brand.fromMap(Map<String, dynamic> mapData) {
    return Brand(
      id: mapData['id'],
      name: mapData['name'],
      createdAt: DateTime.parse(mapData['createdAt']),
    );
  }
}