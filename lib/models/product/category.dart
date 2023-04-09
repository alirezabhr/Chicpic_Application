enum CategoryGender {
  men('M', 'Men'),
  women('W', 'Women');

  final String abbreviation;
  final String humanReadable;

  const CategoryGender(this.abbreviation, this.humanReadable);
}

class Category {
  int id;
  String title;
  late CategoryGender gender;
  String image;

  Category({
    required this.id,
    required this.title,
    required String gender,
    required this.image,
  }) {
    this.gender = gender == CategoryGender.women.abbreviation
        ? CategoryGender.women
        : CategoryGender.men;
  }

  factory Category.fromMap(Map<String, dynamic> categoryData) => Category(
        id: categoryData['id'],
        title: categoryData['title'],
        gender: categoryData['gender'],
        image: categoryData['image'],
      );
}
