import 'dart:convert';

import 'package:ecommerce_app/Model/Product.dart';
import 'package:ecommerce_app/Model/Products.dart';
import 'package:http/http.dart' as http;

class ProducsApi {
  Future<List<Product>> fetchProducts() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://e-commerce-backend-sable.vercel.app/api/v1/user/product'));
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ProductsList products = ProductsList.fromJson(jsonData);
        List<Product> productsList =
            products.products.map((e) => Product.fromJson(e)).toList();
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

  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            'https://e-commerce-backend-sable.vercel.app/api/v1/user/product?categoryId=$categoryId'),
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ProductsList products = ProductsList.fromJson(jsonData);
        List<Product> productsList =
            products.products.map((e) => Product.fromJson(e)).toList();

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
