import 'dart:convert';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/widgets/Categories_Card.dart';
import 'package:ecommerce_app/widgets/PorductCard.dart';
import 'package:ecommerce_app/widgets/subCategoriesCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> Photos = [];

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
    Colors.white54,
    Colors.white54,
  ];
  int activeIndex = 0;
  Map<String, dynamic> data = {};
  Map<String, dynamic> banners = {};
  List<dynamic> categories = [];
  List<dynamic> subCategories = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    fetchBanners();
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
              height: height / 2.4,
              child: FutureBuilder(
                  future: fetchBanners(),
                  builder: (context, snapshot) {
                    if (Photos.length == 0) {
                      return Center(
                          child: Container(
                        child: Text(Photos.toString()),
                      ));
                    }
                    return Image.network(
                      Photos[activeIndex]["image"],
                      fit: BoxFit.cover,
                    );
                  }),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black38,
                width: double.infinity,
                height: height / 2.4,
              ),
            )
          ],
        ),
        Column(
          children: [
            SafeArea(
              child: Row(
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
            ),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    // color: Colors.amber,
                    height: height / 9,
                    width: width / 2.5,
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              changeColorOfButtonn(index);
                              fetchSubCategoriesData(
                                  index,
                                  categories[index]['categoryNameEn']
                                      .toString());
                              if (subCategories.length != 0) {
                                _showModalBottomSheet(
                                    context,
                                    categories[index]['categoryNameEn']
                                        .toString());
                              }
                            },
                            child: CategoriesCard(
                              ColorOfButton: ColorsOfButtons[index],
                              title: categories[index]['categoryNameEn']
                                  .toString(),
                              IconsOfCard: Icon(Icons.directions_run,
                                  color: ColorsOfButtons[index] == Colors.white
                                      ? Colors.white
                                      : Colors.white54),
                            ),
                          );
                        },
                      ),
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
            FutureBuilder(
              future: fetchBanners(),
              builder: (context, snapshot) {
                if (Photos.length != 0) {
                  return Stack(children: [
                    Container(
                      height: height / 4.5,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          spreadRadius: 5,
                          color: Colors.black12,
                        )
                      ]),
                      child: Stack(
                        children: [
                          CarouselSlider.builder(
                              itemCount: Photos.length,
                              itemBuilder: (context, index, realIndex) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      child: buildImage(
                                          Photos[index]["image"].toString(),
                                          index)),
                                );
                              },
                              options: CarouselOptions(
                                viewportFraction:
                                    1, // Set viewportFraction to 1.0
                                enlargeCenterPage: true,
                                height: 1000,
                                autoPlay: true,

                                onPageChanged: (index, reason) => setState(() {
                                  activeIndex = index;
                                  indexOfPhoto = activeIndex;
                                }),
                              )),
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
                  ]);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Expanded(
                child: Container(
              color: MainColors.PrimaryColor.withOpacity(0.2),
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    String categoryNameEn =
                        categories[index]['categoryNameEn'].toString();
                    return ProductCard(title: categoryNameEn);
                  }),
            )),
          ],
        ),
      ],
    );
  }

  Widget buildIndicator(int length) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: length,
      effect: WormEffect(
        activeDotColor: Colors.blue,
        dotColor: Colors.grey,
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
        Colors.white54,
        Colors.white54,
      ];
      ColorsOfButtons[index] = Colors.white;
    });
  }

  Widget buildImage(urlimage, int index) {
    return Image.network(
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

  Future fetchBanners() async {
    final responseOfBanners = await http.get(Uri.parse(
        'https://e-commerce-backend-sable.vercel.app/api/v1/user/banner'));
    if (responseOfBanners.statusCode == 200) {
      setState(() {
        banners = json.decode(responseOfBanners.body);
        Photos = banners["result"];
      });
    } else {
      throw Exception('Failed to load data');
    }
    return banners["result"];
  }

  Future<void> fetchSubCategoriesData(int index, String Category) async {
    subCategories = data["categories"][index]["CategorywithsubCategories"];
  }

  void _showModalBottomSheet(BuildContext context, String Category) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.sizeOf(context).height / 5,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  Category,
                  style: TextStyle(fontSize: 25, fontFamily: "CairoBold"),
                ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: subCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: SubCategoriesCard(
                          title: subCategories[index]["subCategoryNameEn"],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
