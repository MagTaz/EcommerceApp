import 'package:ecommerce_app/Model/Category.dart';
import 'package:ecommerce_app/Services/CategoryApi.dart';
import 'package:flutter/cupertino.dart';

class CategoryListViewModel extends ChangeNotifier {
  List<CategoryModel> _categoryList = [];

  Future fetchProducts() async {
    _categoryList = await CategoriesApi().fetchCategories();
    notifyListeners();
  }

  List<CategoryModel> get categoriesList => _categoryList;
}
