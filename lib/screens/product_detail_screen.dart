import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/ProductDetailsScreen';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProducts =
        Provider.of<Products>(context, listen: false).findbyId(productId);
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      drawerScrimColor: Colors.transparent,
      // appBar: AppBar(
      //   title: Text(loadedProducts.title),
      // ),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              surfaceTintColor: Colors.transparent,
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withAlpha(80),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  margin: const EdgeInsets.only(
                      top: 70, left: 10, right: 10, bottom: 0.0),
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Text(
                      loadedProducts.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                background: Hero(
                  tag: loadedProducts.id,
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 110, left: 10, right: 10, bottom: 11),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 5),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Image.network(
                        loadedProducts.imageUrl,
                        fit: BoxFit.cover,
                        height: size.height * 0.4,
                        width: size.width * 0.95,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: double.infinity,
                        height: size.height * 0.05,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: color.tertiaryContainer),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              loadedProducts.title,
                              style: text.bodyLarge,
                            ),
                            Text(
                              '₹ ${loadedProducts.price}',
                              style: text.bodyLarge,
                            ),
                          ],
                        )),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.lime.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(top: 15),
                      height: size.height * 0.08,
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(loadedProducts.description)),
                    ),
                    const SizedBox(
                      height: 800,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
