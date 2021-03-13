import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './core/constants/strings.dart';
import './core/themes/app_theme.dart';

import './presentation/routers/app_router.dart';

import './data/providers/products.dart';
import './data/providers/orders.dart';
import './data/providers/cart.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products(),),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: Strings.appTitle,
        theme: AppTheme.normalTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}