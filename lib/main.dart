import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/Categories_Card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  List Photos = [
    "assets/img/0.jpg",
    "assets/img/1.jpg",
    "assets/img/2.jpg",
  ];
  List ColorsOfButtons = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: height / 9,
            title: Container(
                height: 50,
                width: width,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Search",
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.indigo,
                      labelStyle: TextStyle(
                          fontFamily: "CairoBold",
                          fontSize: 15,
                          color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.indigo.withOpacity(0.6)))),
                ))),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              // color: Colors.amber,
              height: height / 9,
              width: width,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      ColorsOfButtons = [
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                      ];
                      ColorsOfButtons[0] = Colors.indigo;
                    });
                  },
                  child: CategoriesCard(
                    ColorOfButton: ColorsOfButtons[0],
                    title: "Footwear",
                    IconsOfCard: Icon(Icons.directions_run,
                        color: ColorsOfButtons[0] == Colors.white
                            ? Colors.indigo
                            : Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      ColorsOfButtons = [
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                      ];
                      ColorsOfButtons[1] = Colors.indigo;
                    });
                  },
                  child: CategoriesCard(
                    ColorOfButton: ColorsOfButtons[1],
                    title: "Dresses",
                    IconsOfCard: Icon(Icons.content_cut,
                        color: ColorsOfButtons[1] == Colors.white
                            ? Colors.indigo
                            : Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      ColorsOfButtons = [
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                      ];
                      ColorsOfButtons[2] = Colors.indigo;
                    });
                  },
                  child: CategoriesCard(
                    ColorOfButton: ColorsOfButtons[2],
                    title: "Clothes",
                    IconsOfCard: Icon(Icons.directions_run,
                        color: ColorsOfButtons[2] == Colors.white
                            ? Colors.indigo
                            : Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      ColorsOfButtons = [
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                      ];
                      ColorsOfButtons[3] = Colors.indigo;
                    });
                  },
                  child: CategoriesCard(
                    ColorOfButton: ColorsOfButtons[3],
                    title: "Jackets",
                    IconsOfCard: Icon(Icons.directions_run,
                        color: ColorsOfButtons[3] == Colors.white
                            ? Colors.indigo
                            : Colors.white),
                  ),
                ),
              ]),
            ),
            Container(
              width: width,
              height: height / 3,
              child:
                  // Image.asset("assets/img/2.jpg")
                  Stack(
                children: [
                  CarouselSlider.builder(
                      itemCount: Photos.length,
                      itemBuilder: (context, index, realIndex) {
                        return buildImage(Photos[index], index);
                      },
                      options: CarouselOptions(
                        viewportFraction: 1.0, // Set viewportFraction to 1.0
                        enlargeCenterPage: true,
                        height: 900,
                        autoPlay: true,

                        onPageChanged: (index, reason) => setState(() {
                          activeIndex = index;
                        }),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(bottom: 5),
                      child: buildIndicator(Photos.length),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget buildImage(urlimage, int index) {
    return Image.asset(
      urlimage,
      fit: BoxFit.fitWidth,
    );
  }

  Widget buildIndicator(int length) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: length,
      effect: WormEffect(
        activeDotColor: Colors.blue, // Change the color of active dot
        dotColor: Colors.grey, // Change the color of inactive dots
        dotHeight: 8,
        dotWidth: 8,
        spacing: 10,
      ),
    );
  }
}
