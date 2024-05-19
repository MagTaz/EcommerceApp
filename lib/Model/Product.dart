class Product {
  final String productNameAr;
  final String productNameEn;
  final String price;
  final String categoryId;
  final List<dynamic> images;
  final bool isProductVariable;

  Product(
      {required this.productNameAr,
      required this.productNameEn,
      required this.price,
      required this.categoryId,
      required this.images,
      required this.isProductVariable});

  factory Product.fromJson(Map<String, dynamic> jsonData) {
    return Product(
        productNameAr: jsonData["productNameAr"],
        productNameEn: jsonData["productNameEn"],
        price: jsonData["price"],
        categoryId: jsonData["categoryId"],
        images: jsonData["images"],
        isProductVariable: jsonData["isProductVariable"]);
  }
}
