import 'dart:convert';

import 'package:ecommerce_app/Model/Product.dart';
import 'package:ecommerce_app/Model/Products.dart';
import 'package:http/http.dart' as http;

// class ProducsApi {
//   Future<List<Product>> fetchProducts() async {
//     try {
//       http.Response response = await http.get(Uri.parse(
//           'https://e-commerce-backend-sable.vercel.app/api/v1/user/product'));
//       if (response.statusCode == 200) {
//         String data = response.body;
//         var jsonData = jsonDecode(data);
//         Products producs = Products.fromJson(jsonData);
//         List<Product> producsList =
//             producs.products.map((e) => Product.fromJson(e)).toList();
//         return producsList;
//       } else {
//         print(response.statusCode);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
