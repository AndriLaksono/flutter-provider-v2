import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/providers/cart.dart';
import '../../data/providers/products.dart';

import '../routers/app_router.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum FilterOptions {
  Favorites,
  ShowAll
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (mounted) setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false).fetchSetProducts().then((_) {
      if (mounted) setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Favorite'), value: FilterOptions.Favorites,),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.ShowAll,),
            ]
          ),
          Consumer<Cart>(
            builder: (ctx, cart, ch) => Badge(
              child: ch, 
              value: cart.itemCount.toString()
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart), 
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.cart);
              }
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : ProductsGrid(_showOnlyFavorites),
    );
  }
}