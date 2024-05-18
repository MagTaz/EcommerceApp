import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.title});
  final String title;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final List<String> _randomProductNames = [
    'T-shirt',
    'Jeans',
    'Dress',
    'Sweater',
    'Jacket',
    'Skirt',
    'Blouse',
    'Pants',
    'Shorts',
    'Coat',
    'Shirt',
    'Suit',
    'Top',
    'Hoodie',
    'Cardigan',
    'Tank Top',
    'Sweatshirt',
    'Leggings',
    'Tunic',
    'Jumpsuit',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
        Text(widget.title)
      ],
    );
  }
}
