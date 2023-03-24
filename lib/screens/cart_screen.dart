import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text('₹ ${cartData.totalAmount}'),
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
        ],
      ),
    );
  }
}
