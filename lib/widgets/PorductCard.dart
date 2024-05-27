import 'package:ecommerce_app/Model/Product.dart';
import 'package:ecommerce_app/Screens/ProductDetailsScreen.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/Utils/Text_Style.dart';
import 'package:ecommerce_app/View_Model/ProductsListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.title,
    required this.UrlImage,
    required this.index,
    required this.price,
    required this.ImagesList,
    required this.productDetails,
    required this.categoryId,
  });
  final String title;
  final String UrlImage;
  final int index;
  final String price;
  final List ImagesList;
  final Product productDetails;
  final String categoryId;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      radius: 100,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 600),
            pageBuilder: (context, animation, secondaryAnimation) =>
                ProductDetailsScreen(
              title: widget.title,
              price: widget.price,
              images: widget.ImagesList,
              id: widget.productDetails.productId,
              description: widget.productDetails.productDescriptionEn,
              productVariable: widget.productDetails.productVariable,
              categoryId: widget.categoryId,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0;
              var curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return FadeTransition(
                opacity: animation.drive(tween),
                child: ScaleTransition(
                  scale: animation.drive(tween),
                  child: child,
                ),
              );
            },
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5, spreadRadius: 5, color: Colors.black26)
                ],
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Container(
                  height: 255,
                  child: Stack(
                    children: [
                      Container(
                        height: 255,
                        child: Image.network(
                          widget.UrlImage,
                          fit: BoxFit.cover, // Change this to BoxFit.fill
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 164, 74, 0)
                                .withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          height: 50,
                          width: 70,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.price + " SAR",
                                style:
                                    Text_Style.textStyleBold(Colors.white, 13),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 50,
                  decoration: BoxDecoration(
                    color: MainColors.PrimaryColor.withOpacity(0.3),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: Text_Style.textStyleBold(Colors.white, 15),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
