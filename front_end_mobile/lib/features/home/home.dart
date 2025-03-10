import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../shared/colors.dart';
import '../order-list/order_list_page.dart';
import '../product-list/product_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    const ProductListPage(),
    const OrderListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: AppColors.bottomNavigator,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: GNav(
              backgroundColor: AppColors.bottomNavigator,
              color: AppColors.bottomNavigatorIcon,
              activeColor: AppColors.bottomNavigatorIconActive,
              tabBackgroundColor: AppColors.bottomNavigatorTabBackground,
              gap: 20,
              padding: const EdgeInsets.all(16),
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Produtos',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Pedidos',
                ),
              ]),
        ),
      ),
    );
  }
}
