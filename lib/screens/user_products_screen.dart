import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_products_item.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userproductsscreen';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true)
        .then((value) => null);
  }

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await _refreshProducts(context);
                    },
                    child: Consumer<Products>(
                      builder: (ctx, products, child) => ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: products.items.length,
                          itemBuilder: (ctx, i) {
                            return UserProductItem(
                              id: products.items[i].id,
                              title: products.items[i].title,
                              imageUrl: products.items[i].imageUrl,
                            );
                          }),
                    ),
                  ),
      ),
    );
  }
}
