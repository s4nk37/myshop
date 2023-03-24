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
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 5),
                    borderRadius: BorderRadius.circular(21)),
                child: Image.network(
                  loadedProducts.imageUrl,
                  fit: BoxFit.contain,
                  height: size.height * 0.4,
                  width: size.width * 0.95,
                ),
              ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
