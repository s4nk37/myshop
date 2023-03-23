import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart' as A;

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    // print(productsContainer);
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Shop"),
          actions: [
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                if (selectedValue == FilterOptions.Favorites) {
                  setState(() {
                    _showOnlyFavorites = true;
                  });
                } else if (selectedValue == FilterOptions.All) {
                  setState(() {
                    _showOnlyFavorites = false;
                  });
                }
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white70,
              ),
              color: Colors.green.withOpacity(0.9),
              elevation: 0.0,
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: FilterOptions.Favorites,
                  height: 60,
                  child: Text("Only Favorites"),
                ),
                PopupMenuItem(
                  value: FilterOptions.All,
                  height: 60,
                  child: Text("Show All"),
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (ctx, cart, ch) => A.Badge(
                value: cart.itemCount.toString(),
                child: ch!,
              ),
              child: IconButton(
                  icon: const Icon(Icons.shopping_bag_rounded),
                  onPressed: () {}),
            )
          ],
        ),
        // body: ProductsGrid(loadedProducts: loadedProducts));
        body: ProductsGrid(
          showFavorite: _showOnlyFavorites,
        ));
  }
}
