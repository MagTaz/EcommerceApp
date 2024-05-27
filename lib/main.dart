import 'dart:ui';

import 'package:ecommerce_app/Screens/HomeOfPages.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/View_Model/ProductsListViewModel.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/Categories_Card.dart';

void main() {
  runApp(ChangeNotifierProvider<ProductsListViewModel>(
      create: (BuildContext context) => ProductsListViewModel(),
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, String newLocale) {
    _MyAppState? state = context.findRootAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  String _locale = "en";
  setLocale(String locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(_locale),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: HomeOfPages(),
    );
  }
}
