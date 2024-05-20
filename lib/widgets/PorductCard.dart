import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/Utils/Text_Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.title,
      required this.UrlImage,
      required this.index,
      required this.price});
  final String title;
  final String UrlImage;
  final int index;
  final String price;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 5, spreadRadius: 5, color: Colors.black26)
              ],
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.UrlImage,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //       blurRadius: 5,
                          //       spreadRadius: 2,
                          //       color: Colors.black45,
                          //       offset: Offset(-2, 2))
                          // ],
                          color: const Color.fromARGB(255, 164, 74, 0)
                              .withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20))),
                      height: 50,
                      width: 70,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.price + " SAR",
                            style: Text_Style.textStyleBold(Colors.white, 13),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
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
    );
  }
}
