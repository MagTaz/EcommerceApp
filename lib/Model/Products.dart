import 'package:ecommerce_app/Model/Product.dart';

class Products {
  final List<dynamic> products;

  Products({required this.products});
  factory Products.fromJson(Map<String, dynamic> jsonData) {
    return Products(products: jsonData["result"]);
  }
}
