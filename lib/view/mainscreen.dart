import 'package:flutter/material.dart';
import 'package:recipeapp/view/recipelistdummyscreen.dart';
import 'package:recipeapp/view/recipelistscreen.dart';
import 'package:recipeapp/view/view_all_page.dart';

import 'cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
   RecipeList(),

    CartScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: _selectedIndex,
          children: _screens),

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
       selectedItemColor: Colors.white,
        backgroundColor: Colors.green,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant
              ,color: Colors.white,
              ),
              label: "Recipes",


          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart,
                  color: Colors.white
              ), label: "Cart"),
        ],
      ),
    );
  }
}
