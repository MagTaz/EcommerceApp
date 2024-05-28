import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesCard extends StatefulWidget {
  const CategoriesCard(
      {super.key, required this.title, required this.ColorOfButton});

  final String title;
  final Color ColorOfButton;
  @override
  State<CategoriesCard> createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.height;
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(
            color: widget.ColorOfButton == Colors.black45
                ? MainColors.PrimaryColor.withOpacity(0.3)
                : Colors.transparent,
          ),
          color: widget.ColorOfButton == Colors.black45
              ? Colors.white30
              : MainColors.PrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      height: height,
      child: Center(
        child: Text(
          widget.title,
          style: TextStyle(
              fontFamily: "CairoBold",
              color: widget.ColorOfButton == Colors.black45
                  ? widget.ColorOfButton
                  : Colors.white),
        ),
      ),
    );
  }
}
