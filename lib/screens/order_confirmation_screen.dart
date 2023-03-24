import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:lottie/lottie.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const routeName = '/OrderConfirmationScreen';

  const OrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Shop")),
      drawer: const AppDrawer(),
      body: Center(
        child: Lottie.asset('assets/lottie/successful.json', repeat: false),
      ),
    );
  }
}
