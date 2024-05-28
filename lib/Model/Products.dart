class ProductsList {
  final List<dynamic> products;

  ProductsList({required this.products});
  factory ProductsList.fromJson(Map<String, dynamic> jsonData) {
    return ProductsList(products: jsonData["result"]);
  }
}
