import 'dart:convert';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/widgets/Categories_Card.dart';
import 'package:ecommerce_app/widgets/PorductCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List Photos = [
    "assets/img/0.jpg",
    "assets/img/1.jpg",
    "assets/img/2.jpg",
  ];
  int indexOfPhoto = 0;

  List ColorsOfButtons = [
    Colors.white54,
    Colors.white54,
    Colors.white54,
    Colors.white54,
    Colors.white54,
    Colors.white54,
    Colors.white54,
    Colors.white54,
  ];
  int activeIndex = 0;
  Map<String, dynamic> data = {};
  List<dynamic> categories = [];

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Stack(
          children: [
            Container(
              height: height / 2,
              child: Image.asset(
                Photos[activeIndex],
                fit: BoxFit.fill,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black38,
                width: double.infinity,
                height: height / 2,
              ),
            )
          ],
        ),
        SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.white,
                      )),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Search",
                              prefixIconColor: Colors.white,
                              labelStyle: TextStyle(
                                  fontFamily: "CairoBold",
                                  fontSize: 15,
                                  color: Colors.white54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.white))),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Icon(Icons.search),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                      ))
                ],
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      // color: Colors.amber,
                      height: height / 9,
                      width: width / 2.5,
                      child: Container(
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              InkWell(
                                onTap: () {
                                  changeColorOfButtonn(0);
                                },
                                child: CategoriesCard(
                                  ColorOfButton: ColorsOfButtons[0],
                                  title: "Footwear",
                                  IconsOfCard: Icon(Icons.directions_run,
                                      color: ColorsOfButtons[0] == Colors.white
                                          ? Colors.white
                                          : Colors.white54),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  changeColorOfButtonn(1);
                                },
                                child: CategoriesCard(
                                  ColorOfButton: ColorsOfButtons[1],
                                  title: "Dresses",
                                  IconsOfCard: Icon(Icons.content_cut,
                                      color: ColorsOfButtons[1] == Colors.white
                                          ? Colors.white
                                          : Colors.white54),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  changeColorOfButtonn(2);
                                },
                                child: CategoriesCard(
                                  ColorOfButton: ColorsOfButtons[2],
                                  title: "Clothes",
                                  IconsOfCard: Icon(Icons.directions_run,
                                      color: ColorsOfButtons[2] == Colors.white
                                          ? Colors.white
                                          : Colors.white54),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  changeColorOfButtonn(3);
                                },
                                child: CategoriesCard(
                                  ColorOfButton: ColorsOfButtons[3],
                                  title: "Jackets",
                                  IconsOfCard: Icon(Icons.directions_run,
                                      color: ColorsOfButtons[3] == Colors.white
                                          ? Colors.white
                                          : Colors.white54),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  changeColorOfButtonn(4);
                                },
                                child: CategoriesCard(
                                  ColorOfButton: ColorsOfButtons[4],
                                  title: "Jackets",
                                  IconsOfCard: Icon(Icons.directions_run,
                                      color: ColorsOfButtons[4] == Colors.white
                                          ? Colors.white
                                          : Colors.white54),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  changeColorOfButtonn(5);
                                },
                                child: CategoriesCard(
                                  ColorOfButton: ColorsOfButtons[5],
                                  title: "Jackets",
                                  IconsOfCard: Icon(Icons.directions_run,
                                      color: ColorsOfButtons[5] == Colors.white
                                          ? Colors.white
                                          : Colors.white54),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  changeColorOfButtonn(6);
                                },
                                child: CategoriesCard(
                                  ColorOfButton: ColorsOfButtons[6],
                                  title: "Jackets",
                                  IconsOfCard: Icon(Icons.directions_run,
                                      color: ColorsOfButtons[6] == Colors.white
                                          ? Colors.white
                                          : Colors.white54),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  changeColorOfButtonn(7);
                                },
                                child: CategoriesCard(
                                  ColorOfButton: ColorsOfButtons[7],
                                  title: "Jackets",
                                  IconsOfCard: Icon(Icons.directions_run,
                                      color: ColorsOfButtons[7] == Colors.white
                                          ? Colors.white
                                          : Colors.white54),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 18, horizontal: 5),
                      width: 1.2,
                      color: Colors.white38,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.list_sharp,
                          size: 30,
                          color: Colors.white70,
                        ))
                  ],
                ),
              ),
              Container(
                width: width,
                height: height / 3,
                child: Stack(
                  children: [
                    Container(
                      height: height / 3,
                      child: CarouselSlider.builder(
                          itemCount: Photos.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                                child: buildImage(Photos[index], index));
                          },
                          options: CarouselOptions(
                            viewportFraction:
                                1.0, // Set viewportFraction to 1.0
                            enlargeCenterPage: true,
                            height: 2000,
                            autoPlay: true,

                            onPageChanged: (index, reason) => setState(() {
                              activeIndex = index;
                              indexOfPhoto = activeIndex;
                            }),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(bottom: 5),
                        child: buildIndicator(Photos.length),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 0),
                      itemBuilder: (context, index) {
                        String categoryNameAr =
                            categories[index]['categoryNameAr'].toString();
                        return ProductCard(title: categoryNameAr);
                      })),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildIndicator(int length) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: length,
      effect: WormEffect(
        activeDotColor: Colors.blue, // Change the color of active dot
        dotColor: Colors.grey, // Change the color of inactive dots
        dotHeight: 5,
        dotWidth: 5,
        spacing: 5,
      ),
    );
  }

  void changeColorOfButtonn(int index) {
    setState(() {
      ColorsOfButtons = [
        Colors.white54,
        Colors.white54,
        Colors.white54,
        Colors.white54,
        Colors.white54,
        Colors.white54,
        Colors.white54,
        Colors.white54,
      ];
      ColorsOfButtons[index] = Colors.white;
    });
  }

  Widget buildImage(urlimage, int index) {
    return Image.asset(
      urlimage,
      fit: BoxFit.fitWidth,
    );
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://e-commerce-backend-sable.vercel.app/api/v1/admin/category-sub-category'));

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        categories = data["categories"];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
