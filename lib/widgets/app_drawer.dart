import 'dart:ui';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/screens/user_products_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade200.withOpacity(0.3),
      elevation: 0.0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Column(
            children: [
              AppBar(
                title: const Text("Hello Friend"),
                elevation: 0.0,
                automaticallyImplyLeading: false,
                toolbarHeight: 48,
                backgroundColor: Colors.transparent,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text("Shop"),
                tileColor: Colors.white38,
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text("My Orders"),
                tileColor: Colors.white38,
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(OrdersScreen.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text("Manage Products"),
                tileColor: Colors.white38,
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(UserProductsScreen.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text("Log out"),
                tileColor: Colors.red.withOpacity(0.5),
                onTap: () {
                  Navigator.of(context).pop();
                  Provider.of<Auth>(context, listen: false).logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
