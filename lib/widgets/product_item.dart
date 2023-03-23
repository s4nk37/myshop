import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 5),
          borderRadius: BorderRadius.circular(21)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          footer: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: GridTileBar(
                backgroundColor: Colors.black26,
                leading: Consumer<Product>(
                  builder: (ctx, product, _) => IconButton(
                      onPressed: () {
                        product.toggleFavoriteStatus();
                      },
                      splashColor: Colors.transparent,
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.redAccent,
                      )),
                ),
                title: Text(
                  product.title,
                  textAlign: TextAlign.center,
                ),
                trailing: IconButton(
                    onPressed: () {
                      cart.addItem(product.id, product.price, product.title);
                    },
                    splashColor: Colors.transparent,
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
