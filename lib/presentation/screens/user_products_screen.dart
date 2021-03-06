import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../data/providers/products.dart';
import '../routers/app_router.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.edit_product);
            }
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting 
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Consumer<Products>(
              builder: (ctx, productsData, _) => Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (BuildContext _, int index) {
                  return Column(
                    children: <Widget>[
                      UserProductItem(
                        productsData.items[index].id, 
                        productsData.items[index].title, 
                        productsData.items[index].imageUrl),
                      Divider()
                    ]
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}