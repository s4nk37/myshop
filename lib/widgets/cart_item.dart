import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final Function removeItem;

  const CartItem(
      {Key? key,
      required this.id,
      required this.title,
      required this.price,
      required this.quantity,
      required this.removeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: (direction) {
        removeItem(id);
      },
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.red[400],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          tileColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text(title),
          leading: Text('${quantity} x '),
          trailing: Chip(
            label: Text('₹ ${price}'),
            backgroundColor: Colors.lime.withOpacity(0.1),
            side: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
