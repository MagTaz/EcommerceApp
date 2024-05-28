import 'package:ecommerce_app/Model/Product.dart';
import 'package:ecommerce_app/Services/productsServices.dart';
import 'package:flutter/cupertino.dart';

class ProductsListViewModel extends ChangeNotifier {
  List<Product> _productsList = [];
  List<Product> _recommendList = [];

  Future fetchProducts() async {
    _productsList = await ProductsApi().fetchProducts();
    notifyListeners();
  }

  fetchProductsByCategory(String CategoryId) async {
    _productsList = await ProductsApi().fetchProductsByCategory(CategoryId);
    notifyListeners();
  }

  fetchProductsBySubCategory(String subCategoryId) async {
    _productsList =
        await ProductsApi().fetchProductsBySubCategory(subCategoryId);
    notifyListeners();
  }

  fetchRecommendProducts(String CategoryId) async {
    _recommendList = await ProductsApi().fetchProductsByCategory(CategoryId);
    notifyListeners();
  }

  List<Product> get productsList => _productsList;
  List<Product> get recommendList => _recommendList;
}
