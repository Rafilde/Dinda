import 'package:flutter/cupertino.dart';
import 'package:front_end_mobile/features/home/home.dart';
import 'package:front_end_mobile/features/order-list/order_list_page.dart';
import 'package:front_end_mobile/features/product-list/product_list_page.dart';
import 'package:front_end_mobile/features/register-product/register_product_page.dart';

class AppRoutes {
  static const String REGISTER_PRODUCT = '/register-product';
  static const String PRODUCT_LIST = '/product-list';
  static const String ORDER_LIST = '/order-list';
  static const String HOME = '/';

  static Map<String, WidgetBuilder> routes = {
    REGISTER_PRODUCT: (context) => const RegisterProductPage(),
    PRODUCT_LIST: (context) => const ProductListPage(),
    ORDER_LIST: (context) => const OrderListPage(),
    HOME: (context) => const HomePage(),
  };
}