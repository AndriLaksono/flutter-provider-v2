import 'package:flutter/material.dart';

import '../../core/exceptions/route_exception.dart';
import '../screens/products_overview_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String product_detail = '/product-detail';
  static const String cart = '/cart';
  static const String orders = '/orders';

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
      default:
        throw const RouteException('Route not found!');
    }
  }
}
