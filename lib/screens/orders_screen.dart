import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: ListView.builder(
          itemCount: orderData.order.length,
          itemBuilder: (ctx, i) {
            return ListTile(
              leading: Text(orderData.order[i].amount.toString()),
            );
          }),
    );
  }
}
