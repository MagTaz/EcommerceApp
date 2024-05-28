import 'package:ecommerce_app/generated/l10n.dart';

class Product {
  final String productName;
  final String price;
  final String categoryId;
  final List<dynamic> images;
  final bool isProductVariable;
  final String productId;
  final String productDescriptionEn;
  final List productVariable;

  Product(
      {required this.productName,
      required this.price,
      required this.categoryId,
      required this.images,
      required this.isProductVariable,
      required this.productId,
      required this.productDescriptionEn,
      required this.productVariable});

  factory Product.fromJson(Map<String, dynamic> jsonData) {
    return Product(
        productName: jsonData[S().ProductNameEnAr],
        price: jsonData["price"],
        categoryId: jsonData["categoryId"],
        images: jsonData["images"],
        isProductVariable: jsonData["isProductVariable"],
        productId: jsonData["_id"],
        productDescriptionEn: jsonData[S().productDescriptionEnAr],
        productVariable: jsonData["productVariable"]);
  }
}
