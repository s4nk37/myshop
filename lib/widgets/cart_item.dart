import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  const CartItem({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: 30,
        ),
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white70,
          size: 30,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.1)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          tileColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text(title),
          leading: Text('$quantity x '),
          trailing: Chip(
            label: Text('₹ $price'),
            backgroundColor: Colors.lime.withOpacity(0.1),
            side: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
