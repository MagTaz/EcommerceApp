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
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 3,
                  color: widget.ColorOfButton == Colors.white54
                      ? Colors.transparent
                      : Colors.white))),
      height: height,
      child: Row(
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontFamily: "CairoBold",
                color: widget.ColorOfButton == Colors.white54
                    ? Colors.white70
                    : Colors.white),
          )
        ],
      ),
    );
  }
}
