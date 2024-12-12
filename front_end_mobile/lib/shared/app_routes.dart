import 'package:flutter/cupertino.dart';
import 'package:front_end_mobile/features/home/home.dart';
import 'package:front_end_mobile/features/order-list/order_list_page.dart';
import 'package:front_end_mobile/features/product-details/product_datils_page.dart';
import 'package:front_end_mobile/features/product-list/product_list_page.dart';
import 'package:front_end_mobile/features/register-product/register_product_page.dart';

class AppRoutes {
  static const String registerProduct = '/register-product';
  static const String productList = '/product-list';
  static const String orderList = '/order-list';
  static const String productDetails = '/product-details';
  static const String home = '/';

  static Map<String, WidgetBuilder> routes = {
    registerProduct: (context) => const RegisterProductPage(),
    productList: (context) => const ProductListPage(),
    orderList: (context) => const OrderListPage(),
    productDetails: (context) => const ProductDatilsPage(),
    home: (context) => const HomePage(),
  };
}