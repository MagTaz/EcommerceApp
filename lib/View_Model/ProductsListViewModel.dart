import 'package:ecommerce_app/Model/Product.dart';
import 'package:ecommerce_app/Services/productsServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProductsListViewModel extends ChangeNotifier {
  List<Product> _productsList = [];
  List<Product> _productsListByCategory = [];

  Future fetchProducts() async {
    _productsList = await ProducsApi().fetchProducts();
    notifyListeners();
  }

  fetchProductsByCategory() async {
    // _products = await ProducsApi().fetchProducts();
    notifyListeners();
  }

  List<Product> get productsList => _productsList;
  List<Product> get productsListByCategory => _productsListByCategory;
}
