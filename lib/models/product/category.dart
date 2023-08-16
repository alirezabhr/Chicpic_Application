import 'package:chicpic/models/auth/gender_choices.dart';

class Category {
  int id;
  String title;
  late GenderChoices gender;
  String image;

  Category({
    required this.id,
    required this.title,
    required String gender,
    required this.image,
  }) {
    this.gender = gender == GenderChoices.women.abbreviation
        ? GenderChoices.women
        : GenderChoices.men;
  }

  factory Category.fromMap(Map<String, dynamic> categoryData) => Category(
        id: categoryData['id'],
        title: categoryData['title'],
        gender: categoryData['gender'],
        image: categoryData['image'],
      );
}
