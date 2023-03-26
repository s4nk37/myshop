import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

import 'package:provider/provider.dart';
import '../providers/products.dart';

import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import 'cart_screen.dart';
import '../widgets/badge.dart' as my_badge;

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
  var _isInit = true;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    // Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Products>(context).fetchAndSetProducts();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    // print(productsContainer);
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Shop"),
          centerTitle: true,
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
              color: Theme.of(context).colorScheme.background.withOpacity(0.97),
              elevation: 0.0,
              position: PopupMenuPosition.under,
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
              builder: (ctx, cart, ch) => my_badge.Badge(
                value: cart.itemCount.toString(),
                child: ch!,
              ),
              child: IconButton(
                  icon: const Icon(Icons.shopping_bag_rounded),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  }),
            )
          ],
        ),
        // body: ProductsGrid(loadedProducts: loadedProducts));
        drawer: const AppDrawer(),
        body: ProductsGrid(
          showFavorite: _showOnlyFavorites,
        ));
  }
}
