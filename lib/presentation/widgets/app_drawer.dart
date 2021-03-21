import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/providers/auth.dart';
import '../routers/app_router.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Navigation Lur'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list_alt_rounded),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRouter.orders);
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRouter.user_product);
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              
              Provider.of<Auth>(context, listen: false).logout();
            }
          ),
        ],
      ),
    );
  }
}