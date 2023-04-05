import 'package:flutter/material.dart';
import '../providers/orders.dart' as provider_order;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  final provider_order.OrderItem order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightGreen.withOpacity(0.8),
      margin: const EdgeInsets.all(10),
      elevation: 0.0,
      child: Column(
        children: [
          ListTile(
            title: Text('₹ ${widget.order.amount.toStringAsFixed(2)}'),
            subtitle:
                Text(DateFormat.yMMMd().add_jm().format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_showMore ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _showMore = !_showMore;
                });
              },
            ),
          ),

          // if (_showMore)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            height:
                _showMore ? min(widget.order.products.length * 50.0, 180) : 0,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(12))),
            child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, i) {
                  return ListTile(
                    leading: Text(widget.order.products[i].title),
                    title: Text('× ${widget.order.products[i].quantity}  '),
                    trailing: Text('₹ ${widget.order.products[i].price}'),
                  );
                }),
          ),
          // : Container(),
        ],
      ),
    );
  }
}
