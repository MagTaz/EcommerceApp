import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/Utils/Text_Style.dart';
import 'package:ecommerce_app/View_Model/ProductsListViewModel.dart';
import 'package:ecommerce_app/widgets/PorductCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.title,
    required this.images,
    required this.price,
    required this.id,
    required this.description,
    required this.productVariable,
    required this.categoryId,
  });

  final String title;
  final List images;
  final String price;
  final String id;
  final String description;
  final List productVariable;
  final String categoryId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedSize = -1;
  int _selectedColor = -1;
  int activeIndex = 0;
  List productColorsList = [];
  final List productSizes = [];
  final List productDisplaySizes = [];
  List recommedProduct = [];

  final CarouselController _carouselController = CarouselController();
  @override
  void initState() {
    Provider.of<ProductsListViewModel>(context, listen: false)
        .fetchProductsByCategory(widget.categoryId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List Photos = widget.images;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: width,
        height: 50,
        decoration: BoxDecoration(),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MainColors.PrimaryColor.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            child: Row(
              children: [
                Spacer(),
                Text(
                  "Sign in",
                  style: Text_Style.textStyleBold(Colors.white, 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Iconsax.login,
                  color: Colors.white,
                ),
                Spacer()
              ],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Container(
            width: width,
            height: height / 2,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: Offset(0, 5))
              ],
            ),
            child: Stack(
              children: [
                Container(
                  child: CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: Photos.length,
                      itemBuilder: (context, index, realIndex) {
                        return Stack(
                          children: [
                            buildImage(Photos[activeIndex], index),
                          ],
                        );
                      },
                      options: CarouselOptions(
                        viewportFraction: 1.0,
                        enlargeCenterPage: true,
                        height: 900,
                        autoPlay: false,
                        onPageChanged: (index, reason) => setState(() {
                          activeIndex = index;
                        }),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(bottom: 50),
                    child: buildIndicator(Photos.length),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: DraggableScrollableSheet(
                  initialChildSize: 0.55,
                  minChildSize: 0.55,
                  maxChildSize: 1.0,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 5,
                            blurRadius: 20,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: width,
                              height: 70,
                              child: Align(
                                alignment: Alignment.center,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.images.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: MainColors.PrimaryColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          height: 50,
                                          width: 50,
                                          child: Center(
                                            child: SpinKitSpinningLines(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        InkResponse(
                                          onTap: () {
                                            setState(() {
                                              activeIndex = index;
                                              _carouselController
                                                  .jumpToPage(index);
                                            });
                                          },
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  spreadRadius: 1,
                                                  color: Colors.black26,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            height: 50,
                                            width: 50,
                                            child: Image.network(
                                              Photos[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        if (index == activeIndex)
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: MainColors.PrimaryColor
                                                  .withOpacity(0.3),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            height: 50,
                                            width: 50,
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width / 2,
                                  child: Text(
                                    widget.title,
                                    style: Text_Style.textStyleBold(
                                        Colors.black, 25),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 80,
                                  margin: EdgeInsets.all(20),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        widget.price + " \$",
                                        style: Text_Style.textStyleBold(
                                          MainColors.PrimaryColor,
                                          25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                widget.description,
                                style: Text_Style.textStyleBold(
                                  Colors.black.withOpacity(0.7),
                                  15,
                                ),
                              ),
                            ),
                            if (widget.productVariable[0].containsKey("size"))
                              buildSizeBar(width),
                            if (widget.productVariable[0]
                                    .containsKey("color") ||
                                (widget.productVariable[0]
                                        .containsKey("size") &&
                                    widget.productVariable[0]
                                        .containsKey("color")))
                              buildColorsBar(width),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                "Recommend",
                                style:
                                    Text_Style.textStyleBold(Colors.black, 15),
                              ),
                            ),
                            Container(
                              width: width,
                              child: MasonryGridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: Provider.of<ProductsListViewModel>(
                                          context)
                                      .productsList
                                      .length,
                                  gridDelegate:
                                      SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    ////////////////////////////////////////////////
                                    ///////////////////////////////////////
                                    /////////////////////////////////
                                    //////////////////////////////
                                    var product =
                                        Provider.of<ProductsListViewModel>(
                                                context)
                                            .productsList[0];
                                    if (product.productId == widget.id) {
                                      print(product.categoryId);
                                    }
                                    return ProductCard(
                                        title: product.productNameEn,
                                        UrlImage: product.images[0],
                                        ImagesList: product.images,
                                        index: index,
                                        price: product.price,
                                        productDetails: product,
                                        categoryId: product.categoryId);
                                  }),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildColorsBar(
    double width,
  ) {
    if (!widget.productVariable[0].containsKey("size")) {
      changeColors();
    }

    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      width: width,
      height: 70,
      child: Align(
        alignment: Alignment.center,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: productColorsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                InkResponse(
                  onTap: () {
                    setState(() {
                      _selectedColor = index;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: getColorFromString(productColorsList[index]),
                          boxShadow: _selectedColor == index
                              ? [
                                  BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    color: Colors.black26,
                                  ),
                                ]
                              : [],
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        height: 30,
                        width: 30,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: _selectedColor == index
                            ? Container(
                                margin: EdgeInsets.only(top: 5),
                                key: ValueKey<int>(index),
                                height: 5,
                                width: 25,
                                color: getColorFromString(
                                    productColorsList[index]),
                              )
                            : Container(
                                key: ValueKey<int>(-1),
                                height: 5,
                                width: 25,
                                color: Colors.transparent,
                              ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container buildSizeBar(
    double width,
  ) {
    productSizes.clear();
    for (int i = 0; i < widget.productVariable.length; i++) {
      productSizes.add(widget.productVariable[i]["size"]);
      if (!productDisplaySizes.contains(widget.productVariable[i]["size"])) {
        productDisplaySizes.add(widget.productVariable[i]["size"]);
      }
    }
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      width: width,
      height: 55,
      child: Align(
        alignment: Alignment.center,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: productDisplaySizes.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                InkResponse(
                  onTap: () {
                    setState(() {
                      changeColorWithSize(productSizes[index].toString());
                      _selectedSize = index;
                      _selectedColor = -1;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: _selectedSize == index
                              ? MainColors.PrimaryColor
                              : MainColors.PrimaryColor.withOpacity(0.3),
                          boxShadow: _selectedSize == index
                              ? [
                                  BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    color: Colors.black26,
                                  ),
                                ]
                              : [],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        height: 50,
                        width: 50,
                        child: Center(
                          child: Text(
                            productDisplaySizes[index]
                                .toString()
                                .replaceAll("uk", "")
                                .toUpperCase(),
                            style: Text_Style.textStyleBold(Colors.white, 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildImage(urlimage, int index) {
    return Container(
      child: Stack(
        children: [
          Image.network(
            urlimage,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(int length) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: length,
      effect: WormEffect(
        activeDotColor: MainColors.PrimaryColor,
        dotColor: Colors.grey,
        dotHeight: 4,
        dotWidth: 4,
        spacing: 8,
      ),
    );
  }

  void changeColors() {
    productColorsList = [];
    for (int i = 0; i < widget.productVariable.length; i++) {
      if (!productColorsList.contains(widget.productVariable[i]["color"])) {
        productColorsList.add(widget.productVariable[i]["color"]);
      }
    }
  }

  void changeColorWithSize(String size) {
    productColorsList = [];
    for (int i = 0; i < productSizes.length; i++) {
      if (productSizes[i] == size) {
        productColorsList.add(widget.productVariable[i]["color"].toString());
      }
    }
  }

  Color getColorFromString(String colorName) {
    colorName = colorName.toLowerCase();
    Map<String, Color> colorMap = {
      'red': Colors.red,
      'green': Colors.green,
      'blue': Colors.blue,
      'pink': Colors.pink,
      'purple': Colors.purple,
      'yellow': Colors.yellow
    };

    if (colorMap.containsKey(colorName)) {
      return colorMap[colorName]!;
    } else {
      return Colors.black;
    }
  }
}
