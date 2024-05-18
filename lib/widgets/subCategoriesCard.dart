import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubCategoriesCard extends StatefulWidget {
  const SubCategoriesCard({super.key, required this.title});
  final String title;
  @override
  State<SubCategoriesCard> createState() => _SubCategoriesCardState();
}

class _SubCategoriesCardState extends State<SubCategoriesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10, spreadRadius: 1, color: Colors.black26)
          ]),
      child: Center(
          child: Text(
        widget.title,
        style: TextStyle(
            fontFamily: "CairoBold", color: Color.fromARGB(255, 13, 142, 171)),
      )),
    );
  }
}
