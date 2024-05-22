import 'dart:ui';

import 'package:ecommerce_app/Screens/HomeOfPages.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/View_Model/ProductsListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/Categories_Card.dart';

void main() {
  runApp(ChangeNotifierProvider<ProductsListViewModel>(
      create: (BuildContext context) => ProductsListViewModel(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: MainColors.PrimaryColor,
      debugShowCheckedModeBanner: false,
      home: Center(child: const MyHomePage(title: 'Home')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return HomeOfPages();
  }
}
