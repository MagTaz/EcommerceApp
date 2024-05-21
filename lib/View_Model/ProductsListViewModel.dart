import 'package:ecommerce_app/Model/Product.dart';
import 'package:ecommerce_app/Services/productsServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProductsListViewModel extends ChangeNotifier {
  List<Product> _productsList = [];

  Future fetchProducts() async {
    _productsList = await ProducsApi().fetchProducts();
    notifyListeners();
  }

  fetchProductsByCategory(String CategoryId) async {
    _productsList = await ProducsApi().fetchProductsByCategory(CategoryId);
    notifyListeners();
  }

  fetchProductsBySubCategory(String subCategoryId) async {
    _productsList =
        await ProducsApi().fetchProductsBySubCategory(subCategoryId);
    notifyListeners();
  }

  List<Product> get productsList => _productsList;
}
