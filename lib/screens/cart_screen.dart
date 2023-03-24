import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart';
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    // print(cartData.item.values.runtimeType);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text('₹ ${cartData.totalAmount.toStringAsFixed(2)}'),
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 70),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<Orders>(context, listen: false).addOrder(
                      cartData.items.values.toList(), cartData.totalAmount);
                  cartData.clear();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.surface),
                ),
                child: const Text(
                  "Place Order",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cartData.itemCount,
                  itemBuilder: (ctx, i) {
                    return CartItem(
                      title: cartData.items.values.toList()[i].title,
                      id: cartData.items.values.toList()[i].id,
                      productId: cartData.items.keys.toList()[i],
                      quantity: cartData.items.values.toList()[i].quantity,
                      price: cartData.items.values.toList()[i].price,
                    );
                  })),
        ],
      ),
    );
  }
}
