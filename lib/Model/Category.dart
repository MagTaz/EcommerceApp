import 'package:ecommerce_app/generated/l10n.dart';

class CategoryModel {
  final String categoryId;
  final String categoryName;
  final List CategorywithsubCategories;

  CategoryModel(
      {required this.categoryId,
      required this.categoryName,
      required this.CategorywithsubCategories});
  factory CategoryModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoryModel(
        categoryId: jsonData["_id"],
        categoryName: jsonData[S().CategoryNameEnAr],
        CategorywithsubCategories: jsonData["CategorywithsubCategories"]);
  }
}
