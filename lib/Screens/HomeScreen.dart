import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Model/Product.dart';
import 'package:ecommerce_app/Services/changeLanguage.dart';
import 'package:ecommerce_app/Utils/Fonts.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/View_Model/CategoryListViewModel.dart';
import 'package:ecommerce_app/View_Model/ProductsListViewModel.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:ecommerce_app/widgets/Categories_Card.dart';
import 'package:ecommerce_app/widgets/EmptyProducsAnimationWidget.dart';
import 'package:ecommerce_app/widgets/PorductCard.dart';
import 'package:ecommerce_app/widgets/subCategoriesCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> Photos = [];
  late Future _futureProducts;
  int indexOfPhoto = 0;
  int activeButton = 0;
  int activeSubButton = 0;
  int activeIndex = 0;
  Map<String, dynamic> data = {};
  Map<String, dynamic> banners = {};
  List<dynamic> categories = [];
  List<dynamic> subCategories = [];
  late Future<List<Product>> products;
  late String _languageCode;
  late Future _futureCategoties;
  @override
  void initState() {
    ChangeLanguage.getLanguage().then((value) {
      _languageCode = value;
      print(_languageCode);
    });

    _futureProducts = Provider.of<ProductsListViewModel>(context, listen: false)
        .fetchProducts();
    _futureCategoties =
        Provider.of<CategoryListViewModel>(context, listen: false)
            .fetchProducts();
    categories = Provider.of<CategoryListViewModel>(context, listen: false)
        .categoriesList;

    fetchBanners(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    return Scaffold(
      body: banners.isEmpty
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
                      future: fetchBanners(context),
                      builder: (context, snapshot) {
                        if (Photos.length != 0) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            width: width,
                            height: height / 4.5,
                            decoration: const BoxDecoration(
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
                                      viewportFraction: 1,
                                      enlargeCenterPage: true,
                                      height: 1000,
                                      autoPlay: Photos.isEmpty,
                                      onPageChanged: (index, reason) =>
                                          setState(() {
                                        activeIndex = index;
                                        indexOfPhoto = activeIndex;
                                      }),
                                    )),
                              ],
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Container();
                        }
                      },
                    ),
                    CategoriesBar(width),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: FutureBuilder(
                            future: _futureProducts,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: SpinKitSpinningLines(
                                    color: MainColors.PrimaryColor,
                                    size: 60,
                                  ),
                                );
                              }
                              if (Provider.of<ProductsListViewModel>(context)
                                  .productsList
                                  .isEmpty) {
                                return const EmptyProductsAnimationWidget();
                              }
                              return Container(
                                child: MasonryGridView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        Provider.of<ProductsListViewModel>(
                                                context)
                                            .productsList
                                            .length,
                                    gridDelegate:
                                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      var product =
                                          Provider.of<ProductsListViewModel>(
                                                  context)
                                              .productsList[index];

                                      return ProductCard(
                                        title: product.productName,
                                        UrlImage: product.images[0],
                                        ImagesList: product.images,
                                        index: index,
                                        price: product.price,
                                        productDetails: product,
                                        categoryId: product.categoryId,
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

  CategoriesBar(double width) {
    return FutureBuilder(
        future: _futureCategoties,
        builder: (context, snapshot) {
          if (Provider.of<CategoryListViewModel>(context)
              .categoriesList
              .isEmpty) {
            return Container();
          }
          return Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: width / 2.5,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Provider.of<CategoryListViewModel>(context)
                        .categoriesList
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      var categoryDetails = Provider.of<CategoryListViewModel>(
                              context,
                              listen: false)
                          .categoriesList[index];

                      if (index == 0) {
                        return InkWell(
                          onTap: () {
                            changeProductsList(index, "");
                            changeColorOfButtonn(index);
                          },
                          child: CategoriesCard(
                            ColorOfButton: activeButton == index
                                ? Colors.white
                                : Colors.black45,
                            title: "All",
                          ),
                        );
                      } else {
                        int categoryIndex = index - 1;
                        return InkWell(
                          onTap: () {
                            if (activeButton != index) {
                              changeProductsList(
                                  index, categoryDetails.categoryId);
                              setState(() {
                                activeSubButton = 0;
                              });
                            }
                            changeColorOfButtonn(index);

                            fetchSubCategoriesData(
                                categoryIndex, categoryDetails.categoryName);
                            if (subCategories.length != 0) {
                              _showModalBottomSheet(
                                  context, categoryDetails.categoryName, index);
                            }
                          },
                          child: CategoriesCard(
                            ColorOfButton: activeButton == index
                                ? Colors.white
                                : Colors.black45,
                            title: categoryDetails.categoryName,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 2),
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
        });
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
              margin: const EdgeInsets.only(top: 10),
              height: 40,
              child: TextField(
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.7),
                    fontFamily: Fonts.PrimaryFont),
                decoration: InputDecoration(
                    labelText: S.of(context).Search_TextField,
                    prefixIconColor: Colors.white,
                    labelStyle: TextStyle(
                      fontFamily: "CairoBold",
                      fontSize: 13,
                      color: MainColors.PrimaryColor.withOpacity(0.2),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: _languageCode == "en"
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))
                            : const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: _languageCode == "en"
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))
                            : const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                        borderSide: BorderSide(
                          color: MainColors.PrimaryColor,
                        ))),
              )),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 50,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: _languageCode == "en"
                ? const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
            color: MainColors.PrimaryColor,
          ),
          child: const Icon(
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

  void changeColorOfButtonn(int index) {
    setState(() {
      activeButton = index;
    });
  }

  void changeColorOfSubButtonn(int index) {
    setState(() {
      activeSubButton = index;
    });
  }

  void changeProductsList(int index, String categoryId) {
    if (index == 0) {
      setState(() {
        _futureProducts =
            Provider.of<ProductsListViewModel>(context, listen: false)
                .fetchProducts();
      });
    } else {
      setState(() {
        _futureProducts =
            Provider.of<ProductsListViewModel>(context, listen: false)
                .fetchProductsByCategory(categoryId);
      });
    }
  }

  void changeProductsListFromSubCatogery(int index, String subCategoryId) {
    if (index == 0) {
      setState(() {
        _futureProducts =
            Provider.of<ProductsListViewModel>(context, listen: false)
                .fetchProductsBySubCategory(subCategoryId);
      });
    } else {
      setState(() {
        _futureProducts =
            Provider.of<ProductsListViewModel>(context, listen: false)
                .fetchProductsBySubCategory(subCategoryId);
      });
    }
  }

  Widget buildImage(urlimage, int index) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
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

  Future fetchBanners(BuildContext context) async {
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
      print(e);
      // Map<String, dynamic> error = json.decode(responseOfBanners.body);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.red,
      //     content: Text(error["message"]),
      //   ),
      // );
    }
  }

  Future<void> fetchSubCategoriesData(int index, String Category) async {
    subCategories = data["categories"][index]["CategorywithsubCategories"];
  }

  void _showModalBottomSheet(
      BuildContext context, String Category, int CatogeryIndex) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.sizeOf(context).height / 5,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  Category,
                  style: const TextStyle(fontSize: 25, fontFamily: "CairoBold"),
                ),
              ),
              Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: subCategories.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return index == 0
                          ? InkWell(
                              onTap: () {
                                changeProductsList(index + 1,
                                    categories[CatogeryIndex - 1]["_id"]);
                                changeColorOfSubButtonn(index);
                                Navigator.pop(context);
                              },
                              child: SubCategoriesCard(
                                title: "All",
                                ColorOfButton: index == activeSubButton
                                    ? MainColors.PrimaryColor
                                    : Colors.black45,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                changeProductsListFromSubCatogery(
                                    index, subCategories[index - 1]["_id"]);
                                changeColorOfSubButtonn(index);
                                Navigator.pop(context);
                              },
                              child: SubCategoriesCard(
                                title: subCategories[index == 0 ? 0 : index - 1]
                                    ["subCategoryNameEn"],
                                ColorOfButton: index == activeSubButton
                                    ? MainColors.PrimaryColor
                                    : Colors.black45,
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
