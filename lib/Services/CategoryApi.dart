import 'dart:convert';

import 'package:ecommerce_app/Model/Categories.dart';
import 'package:ecommerce_app/Model/Category.dart';

import 'package:http/http.dart' as http;

class CategoriesApi {
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://e-commerce-backend-sable.vercel.app/api/v1/admin/category-sub-category'));
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        CategoriesList categoriesList = CategoriesList.fromJson(jsonData);
        List<CategoryModel> productsList = categoriesList.categories
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        return productsList;
      } else {
        print(response.statusCode);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
