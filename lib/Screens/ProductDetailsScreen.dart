import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/Utils/Text_Style.dart';
import 'package:ecommerce_app/View_Model/ProductsListViewModel.dart';
import 'package:ecommerce_app/generated/l10n.dart';
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
  late Future _futureProducts;

  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _futureProducts = Provider.of<ProductsListViewModel>(context, listen: false)
        .fetchRecommendProducts(widget.categoryId);

    List Photos = widget.images;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: width,
        height: 50,
        decoration: const BoxDecoration(),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MainColors.PrimaryColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            child: Row(
              children: [
                const Spacer(),
                Text(
                  S().addToCartButton_ProductDetailsScreen,
                  style: Text_Style.textStyleBold(Colors.white, 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Iconsax.shopping_cart,
                  color: Colors.white,
                ),
                const Spacer()
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
            decoration: const BoxDecoration(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(bottom: 50),
                    child: buildIndicator(Photos.length),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
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
                      decoration: const BoxDecoration(
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
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
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
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: MainColors.PrimaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          height: 50,
                                          width: 50,
                                          child: const Center(
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
                                            margin: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
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
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: MainColors.PrimaryColor
                                                  .withOpacity(0.3),
                                              borderRadius:
                                                  const BorderRadius.all(
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
                            const SizedBox(
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
                                const Spacer(),
                                Container(
                                  width: 80,
                                  margin: const EdgeInsets.all(20),
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
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
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
                              margin: const EdgeInsets.only(top: 20),
                              child: Provider.of<ProductsListViewModel>(context)
                                      .recommendList
                                      .isEmpty
                                  ? Container()
                                  : Text(
                                      S().RecommendedProducts_ProductDetailsScreen,
                                      style: Text_Style.textStyleBold(
                                          Colors.black, 15),
                                    ),
                            ),
                            FutureBuilder(
                              future: _futureProducts,
                              builder: (context, snapshot) {
                                return Container(
                                  width: width,
                                  child: MasonryGridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        Provider.of<ProductsListViewModel>(
                                                context)
                                            .recommendList
                                            .length,
                                    gridDelegate:
                                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      var recommendList =
                                          Provider.of<ProductsListViewModel>(
                                                  context)
                                              .recommendList;
                                      if (recommendList.isEmpty) {
                                        return Center(
                                          child: SpinKitSpinningLines(
                                            color: MainColors.PrimaryColor,
                                            size: 60,
                                          ),
                                        );
                                      } else if (index < recommendList.length) {
                                        var product = recommendList[index];
                                        return ProductCard(
                                          title: product.productName,
                                          UrlImage: product.images[0],
                                          ImagesList: product.images,
                                          index: index,
                                          price: product.price,
                                          productDetails: product,
                                          categoryId: product.categoryId,
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  ),
                                );
                              },
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
      margin: const EdgeInsets.only(
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
                        padding: const EdgeInsets.all(5),
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: getColorFromString(productColorsList[index]),
                          boxShadow: _selectedColor == index
                              ? [
                                  const BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    color: Colors.black26,
                                  ),
                                ]
                              : [],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        height: 30,
                        width: 30,
                        child: const Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _selectedColor == index
                            ? Container(
                                margin: const EdgeInsets.only(top: 5),
                                key: ValueKey<int>(index),
                                height: 5,
                                width: 25,
                                color: getColorFromString(
                                    productColorsList[index]),
                              )
                            : Container(
                                key: const ValueKey<int>(-1),
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
      margin: const EdgeInsets.only(
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
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: _selectedSize == index
                              ? MainColors.PrimaryColor
                              : MainColors.PrimaryColor.withOpacity(0.3),
                          boxShadow: _selectedSize == index
                              ? [
                                  const BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    color: Colors.black26,
                                  ),
                                ]
                              : [],
                          borderRadius: const BorderRadius.all(
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
