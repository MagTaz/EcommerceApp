import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/Utils/Text_Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.title,
    required this.images,
    required this.price,
    required this.id,
    required this.description,
  });

  final String title;
  final List images;
  final String price;
  final String id;
  final String description;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int activeIndex = 0;
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    List Photos = widget.images;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                        autoPlay: true,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          spreadRadius: 10,
                          blurRadius: 20)
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                width: width,
                height: height - (height / 2) + 40,
                padding: EdgeInsets.all(20),
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
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                InkResponse(
                                  onTap: () {
                                    setState(() {
                                      activeIndex = index;
                                      _carouselController.jumpToPage(index);
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
                                              color: Colors.black26)
                                        ],
                                        color: MainColors.PrimaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
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
                                        color:
                                            MainColors.PrimaryColor.withOpacity(
                                                0.3),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
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
                      height: 50,
                    ),
                    Row(
                      children: [
                        Container(
                          width: width / 2,
                          child: Text(
                            widget.title,
                            style: Text_Style.textStyleBold(Colors.black, 25),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Text(
                            widget.price + " \$",
                            style: Text_Style.textStyleBold(
                                MainColors.PrimaryColor, 25),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            widget.description,
                            style: Text_Style.textStyleBold(
                                Colors.black.withOpacity(0.7), 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
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
}
