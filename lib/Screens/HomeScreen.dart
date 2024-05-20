import 'dart:async';
import 'dart:convert';

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Model/Product.dart';
import 'package:ecommerce_app/Services/productsServices.dart';
import 'package:ecommerce_app/Utils/Fonts.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/View_Model/ProductsListViewModel.dart';
import 'package:ecommerce_app/widgets/Categories_Card.dart';
import 'package:ecommerce_app/widgets/PorductCard.dart';
import 'package:ecommerce_app/widgets/subCategoriesCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> Photos = [];

  int indexOfPhoto = 0;
  int activeButton = 3;

  int activeIndex = 0;
  Map<String, dynamic> data = {};
  Map<String, dynamic> banners = {};
  List<dynamic> categories = [];
  List<dynamic> subCategories = [];
  late Future<List<Product>> products;

  @override
  void initState() {
    fetchData();
    fetchBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    return Scaffold(
      body: banners.isEmpty || categories.isEmpty
          ? Center(
              child: SpinKitSpinningLines(
                color: MainColors.PrimaryColor,
                size: 60,
              ),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        SafeArea(
                          child: SearchAppBar(),
                        ),
                      ],
                    ),
                    FutureBuilder(
                      future: fetchBanners(),
                      builder: (context, snapshot) {
                        if (Photos.length != 0) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            height: height / 4.5,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Stack(
                              children: [
                                CarouselSlider.builder(
                                    itemCount: Photos.length,
                                    itemBuilder: (context, index, realIndex) {
                                      return Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                            child: buildImage(
                                                Photos[index]["image"]
                                                    .toString(),
                                                index)),
                                      );
                                    },
                                    options: CarouselOptions(
                                      viewportFraction:
                                          1, // Set viewportFraction to 1.0
                                      enlargeCenterPage: true,
                                      height: 1000,
                                      autoPlay: true,

                                      onPageChanged: (index, reason) =>
                                          setState(() {
                                        activeIndex = index;
                                        indexOfPhoto = activeIndex;
                                      }),
                                    )),
                              ],
                            ),
                          );
                        } else {
                          return Center(
                              child: const CircularProgressIndicator());
                        }
                      },
                    ),
                    CategoriesBar(width),
                    activeButton > 0
                        ? Expanded(
                            child: Container(
                              child: FutureBuilder(
                                  future: Provider.of<ProductsListViewModel>(
                                          context,
                                          listen: false)
                                      .fetchProductsByCategory(
                                          categories[activeButton - 1]["_id"]),
                                  builder: (context, snapshot) {
                                    return Container(
                                      child: MasonryGridView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: Provider.of<
                                                      ProductsListViewModel>(
                                                  context)
                                              .productsListByCategory
                                              .length,
                                          gridDelegate:
                                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2),
                                          itemBuilder: (context, index) {
                                            var product = Provider.of<
                                                        ProductsListViewModel>(
                                                    context)
                                                .productsListByCategory[index];

                                            return ProductCard(
                                              title: product.productNameEn,
                                              UrlImage: product.images[0],
                                              index: index,
                                              price: product.price,
                                            );
                                          }),
                                    );
                                  }),
                            ),
                          )
                        : Expanded(
                            child: Container(
                              child: FutureBuilder(
                                  future: Provider.of<ProductsListViewModel>(
                                          context,
                                          listen: false)
                                      .fetchProducts(),
                                  builder: (context, snapshot) {
                                    return Container(
                                      child: MasonryGridView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: Provider.of<
                                                      ProductsListViewModel>(
                                                  context)
                                              .productsList
                                              .length,
                                          gridDelegate:
                                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2),
                                          itemBuilder: (context, index) {
                                            var product = Provider.of<
                                                        ProductsListViewModel>(
                                                    context)
                                                .productsList[index];

                                            return ProductCard(
                                              title: product.productNameEn,
                                              UrlImage: product.images[0],
                                              index: index,
                                              price: product.price,
                                            );
                                          }),
                                    );
                                  }),
                            ),
                          ),
                  ],
                ),
              ],
            ),
    );
  }

  Container CategoriesBar(double width) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            width: width / 2.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return InkWell(
                    onTap: () {
                      changeColorOfButtonn(index);
                    },
                    child: CategoriesCard(
                      ColorOfButton:
                          activeButton == index ? Colors.white : Colors.black45,
                      title: "All",
                    ),
                  );
                } else {
                  int categoryIndex = index - 1;
                  return InkWell(
                    onTap: () {
                      changeColorOfButtonn(index);
                      fetchSubCategoriesData(
                          categoryIndex,
                          categories[categoryIndex]['categoryNameEn']
                              .toString());
                      if (subCategories.length != 0) {
                        _showModalBottomSheet(
                            context,
                            categories[categoryIndex]['categoryNameEn']
                                .toString());
                      }
                    },
                    child: CategoriesCard(
                      ColorOfButton:
                          activeButton == index ? Colors.white : Colors.black45,
                      title: categories[categoryIndex]['categoryNameEn']
                          .toString(),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 9, horizontal: 2),
            width: 1.2,
            color: MainColors.PrimaryColor,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.list_sharp,
                size: 30,
                color: MainColors.PrimaryColor,
              ))
        ],
      ),
    );
  }

  Row SearchAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.mail,
              color: MainColors.PrimaryColor,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.date_range,
              color: MainColors.PrimaryColor,
            )),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(top: 10),
              height: 40,
              child: TextField(
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.7),
                    fontFamily: Fonts.PrimaryFont),
                decoration: InputDecoration(
                    labelText: "Search",
                    prefixIconColor: Colors.white,
                    labelStyle: TextStyle(
                      fontFamily: "CairoBold",
                      fontSize: 13,
                      color: MainColors.PrimaryColor.withOpacity(0.2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        borderSide: BorderSide(
                          color: MainColors.PrimaryColor,
                        ))),
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
            color: MainColors.PrimaryColor,
          ),
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border_outlined,
              color: MainColors.PrimaryColor,
            ))
      ],
    );
  }

  // Widget buildIndicator(int length) {
  //   return AnimatedSmoothIndicator(
  //     activeIndex: activeIndex,
  //     count: length,
  //     effect: WormEffect(
  //       activeDotColor: Colors.blue,
  //       dotColor: Colors.grey,
  //       dotHeight: 5,
  //       dotWidth: 5,
  //       spacing: 5,
  //     ),
  //   );
  // }

  void changeColorOfButtonn(int index) {
    setState(() {
      activeButton = index;
    });
  }

  Widget buildImage(urlimage, int index) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 10, spreadRadius: 5, color: Colors.black26)
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Stack(
          children: [
            Image.network(
              urlimage,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://e-commerce-backend-sable.vercel.app/api/v1/admin/category-sub-category'));
    try {
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          categories = data["categories"];
        });
      } else {
        Map<String, dynamic> error = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(error["message"]),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future fetchBanners() async {
    final responseOfBanners = await http.get(Uri.parse(
        'https://e-commerce-backend-sable.vercel.app/api/v1/user/banner'));
    try {
      if (responseOfBanners.statusCode == 200) {
        setState(() {
          banners = json.decode(responseOfBanners.body);
          Photos = banners["result"];
        });
      } else {
        throw Exception('Failed to load data');
      }
      return banners["result"];
    } catch (e) {
      Map<String, dynamic> error = json.decode(responseOfBanners.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(error["message"]),
        ),
      );
    }
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
