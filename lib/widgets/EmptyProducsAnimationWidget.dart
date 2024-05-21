import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/Utils/Text_Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class EmptyProductsAnimationWidget extends StatefulWidget {
  const EmptyProductsAnimationWidget({super.key});

  @override
  State<EmptyProductsAnimationWidget> createState() =>
      _EmptyProductsAnimationWidgetState();
}

class _EmptyProductsAnimationWidgetState
    extends State<EmptyProductsAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            Lottie.asset(
              'assets/Animation/EmptyAnimation.json',
              repeat: false,
              fit: BoxFit.cover,
            ),
            Text(
              "There is products in this category",
              style: Text_Style.textStyleBold(
                  MainColors.PrimaryColor.withOpacity(0.5), 20),
            )
          ],
        ),
      ),
    );
    ;
  }
}
