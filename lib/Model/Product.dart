class Product {
  final String productNameAr;
  final String productNameAEn;
  final String price;
  final String categoryId;
  final List<dynamic> images;
  final bool isProductVariable;

  Product(
      {required this.productNameAr,
      required this.productNameAEn,
      required this.price,
      required this.categoryId,
      required this.images,
      required this.isProductVariable});

  factory Product.fromJson(Map<String, dynamic> jsonData) {
    return Product(
        productNameAr: jsonData["productNameAr"],
        productNameAEn: jsonData["productNameEn"],
        price: jsonData["price"],
        categoryId: jsonData["categoryId"],
        images: jsonData["images"],
        isProductVariable: jsonData["isProductVariable"]);
  }
}
