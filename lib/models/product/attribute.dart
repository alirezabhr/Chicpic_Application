import 'package:equatable/equatable.dart';

class Attribute extends Equatable {
  final String name;
  final String value;

  const Attribute({required this.name, required this.value});

  factory Attribute.fromMap(Map<String, dynamic> mapData) =>
      Attribute(name: mapData['name'], value: mapData['value']);

  @override
  List<Object?> get props => [name, value];
}
