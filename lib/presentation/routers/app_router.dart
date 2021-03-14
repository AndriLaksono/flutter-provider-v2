import 'package:flutter/material.dart';

import '../../core/exceptions/route_exception.dart';
import '../screens/products_overview_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/edit_product_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String product_detail = '/product-detail';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String edit_product = '/edit-product';
  static const String user_product = '/user-product';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => ProductsOverviewScreen());
      case product_detail:
        return MaterialPageRoute(settings: settings, builder: (_) => ProductDetailScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case orders:
        return MaterialPageRoute(builder: (_) => OrdersScreen());
      case user_product:
        return MaterialPageRoute(builder: (_) => UserProductsScreen());
      case edit_product:
        return MaterialPageRoute(settings: settings, builder: (_) => EditProductScreen());
      default:
        throw const RouteException('Route not found!');
    }
  }
}
