import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../providers/auth.dart';
import '../screens/auth-screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/order_confirmation_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import 'package:provider/provider.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import 'theme.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (ctx, auth, previousProducts) => previousProducts!
            ..receiveToken(auth.token.toString(), auth.userId.toString(),
                previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (ctx, auth, previousOrders) => previousOrders!
            ..receiveToken(auth.token.toString(), auth.userId.toString(),
                previousOrders == null ? [] : previousOrders.order),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                title: 'My Shop',
                debugShowCheckedModeBanner: false,
                theme: myTheme(type: lightColorScheme),
                darkTheme: myTheme(type: darkColorScheme),
                themeMode: ThemeMode.dark,
                home: auth.isAuth
                    ? const ProductsOverviewScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) =>
                            authResultSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? const SplashScreen()
                                : const AuthScreen(),
                      ),
                routes: {
                  ProductDetailScreen.routeName: (ctx) =>
                      const ProductDetailScreen(),
                  CartScreen.routeName: (ctx) => const CartScreen(),
                  OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                  OrderConfirmationScreen.routeName: (ctx) =>
                      const OrderConfirmationScreen(),
                  UserProductsScreen.routeName: (ctx) =>
                      const UserProductsScreen(),
                  EditProductScreen.routeName: (ctx) =>
                      const EditProductScreen(),
                  AuthScreen.routeName: (ctx) => const AuthScreen(),
                },
              )),
    );
  }
}
