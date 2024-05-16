import 'package:ecommerce_app/Screens/HomeScreen.dart';
import 'package:ecommerce_app/Screens/ProfileScreen.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeOfPages extends StatefulWidget {
  const HomeOfPages({super.key});

  @override
  State<HomeOfPages> createState() => _HomeOfPagesState();
}

class _HomeOfPagesState extends State<HomeOfPages> {
  int _selectedIndex = 0;

  List Pages = [HomeScreen(), ProfileScreen()];
  int indexOfPhoto = 0;
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 1,
          selectedIconTheme: IconThemeData(),
          fixedColor: MainColors.PrimaryColor,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.search_outlined),
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        body: Pages[_selectedIndex]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
