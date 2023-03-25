import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_products_item.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userproductsscreen';

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.items.length,
          itemBuilder: (ctx, i) {
            return UserProductItem(
              title: products.items[i].title,
              imageUrl: products.items[i].imageUrl,
            );
          }),
    );
  }
}
