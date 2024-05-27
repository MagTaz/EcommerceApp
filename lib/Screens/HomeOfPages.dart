import 'package:ecommerce_app/Screens/CartScreen.dart';
import 'package:ecommerce_app/Screens/HomeScreen.dart';
import 'package:ecommerce_app/Screens/ProfileScreen.dart';
import 'package:ecommerce_app/Screens/SettingsScreen.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeOfPages extends StatefulWidget {
  const HomeOfPages({super.key});

  @override
  State<HomeOfPages> createState() => _HomeOfPagesState();
}

class _HomeOfPagesState extends State<HomeOfPages> {
  int _selectedIndex = 0;

  List Pages = [
    const HomeScreen(),
    const ProfileScreen(),
    CartScreen(),
    SettingsScreen()
  ];
  int indexOfPhoto = 0;
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          height: 70,
          backgroundColor: Colors.white,
          indicatorColor: MainColors.PrimaryColor.withOpacity(0.6),
          selectedIndex: activeIndex,
          onDestinationSelected: _onItemTapped,
          shadowColor: Colors.black,
          elevation: 30,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Iconsax.shop,
                color: Colors.black,
              ),
              label: S.of(context).ShopAppBar,
              selectedIcon: Icon(
                Iconsax.shop5,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: Icon(Iconsax.shopping_cart),
              label: "Cart",
              selectedIcon: Icon(
                Iconsax.shopping_cart5,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              label: "Profile",
              selectedIcon: Icon(
                Iconsax.user,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: Icon(Iconsax.setting_2),
              label: "Settings",
              selectedIcon: Icon(Iconsax.setting),
            ),
          ],
        ),
        body: Pages[_selectedIndex]);
  }

  void _onItemTapped(int index) {
    setState(() {
      activeIndex = index;
      _selectedIndex = index;
    });
  }
}
