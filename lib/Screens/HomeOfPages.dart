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
    const CartScreen(),
    const ProfileScreen(),
    const SettingsScreen()
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
              icon: const Icon(
                Iconsax.shop,
                color: Colors.black,
              ),
              label: S.of(context).ShopAppBar,
              selectedIcon: const Icon(
                Iconsax.shop5,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Iconsax.shopping_cart),
              label: S.of(context).CartAppBar,
              selectedIcon: const Icon(
                Iconsax.shopping_cart5,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Iconsax.user),
              label: S.of(context).ProfileAppBar,
              selectedIcon: const Icon(
                Iconsax.user,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Iconsax.setting_2),
              label: S.of(context).SettingsAppBar,
              selectedIcon: const Icon(Iconsax.setting),
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
