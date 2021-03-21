import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './core/constants/strings.dart';
import './core/themes/app_theme.dart';

import './presentation/routers/app_router.dart';

import './data/providers/auth.dart';
import './data/providers/products.dart';
import './data/providers/orders.dart';
import './data/providers/cart.dart';

// screens
import './presentation/screens/products_overview_screen.dart';
import './presentation/screens/auth_screen.dart';
import './presentation/screens/splash_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth(),),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => null,
          update: (context, auth, previousProduct) => Products(
            auth.token,
            auth.userID,
            previousProduct == null ? [] : previousProduct.items
          ),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => null,
          update: (context, auth, previousOrders) => Orders(
            auth.token,
            auth.userID,
            previousOrders == null ? [] : previousOrders.orders
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: Strings.appTitle,
          theme: AppTheme.normalTheme,
          debugShowCheckedModeBanner: false,
          home: auth.isAuth 
                ? ProductsOverviewScreen() 
                : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}