import 'package:admin_panel/src/screens/add_new_product_screen/add_new_product_screen.dart';
import 'package:admin_panel/src/screens/all_product_view/all_product_view_screen.dart';
import 'package:admin_panel/src/screens/home_screen/home_screen.dart';
import 'package:admin_panel/src/screens/order_management_screen/order_management_screen.dart';
import 'package:admin_panel/src/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int currentIndex = 0;

  void changeIndex(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const OrderManagementScreen(),
    const AllProductViewScreen(),
    const AddNewProductScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => changeIndex(value),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "All product"),
          BottomNavigationBarItem(
              icon: Icon(Icons.ice_skating), label: "Add Product"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "Profile"),
        ],
      ),
      body: _screens[currentIndex],
    );
  }
}
