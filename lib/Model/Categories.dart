class CategoriesList {
  final List<dynamic> categories;

  CategoriesList({required this.categories});
  factory CategoriesList.fromJson(Map<String, dynamic> jsonData) {
    return CategoriesList(categories: jsonData["categories"]);
  }
}
