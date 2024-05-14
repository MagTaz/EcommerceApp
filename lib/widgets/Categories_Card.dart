import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesCard extends StatefulWidget {
  const CategoriesCard(
      {super.key,
      required this.IconsOfCard,
      required this.title,
      required this.ColorOfButton});
  final Icon IconsOfCard;
  final String title;
  final Color ColorOfButton;
  @override
  State<CategoriesCard> createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: widget.ColorOfButton,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black26)
          ]),
      height: height,
      child: Row(
        children: [
          widget.IconsOfCard,
          SizedBox(
            width: 10,
          ),
          Text(
            widget.title,
            style: TextStyle(
                fontFamily: "CairoBold",
                color: widget.ColorOfButton == Colors.white
                    ? Colors.black
                    : Colors.white),
          )
        ],
      ),
    );
  }
}
