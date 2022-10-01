import 'package:flutter/material.dart';
import 'package:section08/providers/cart.dart';
import 'package:section08/providers/orders.dart';
import 'package:section08/routes/cart_screen.dart';
import 'package:section08/routes/edit_product_screen.dart';
import 'package:section08/routes/orders_screen.dart';
import 'package:section08/routes/product_detail_screen.dart';
import 'package:section08/routes/products_overview_screen.dart';
import 'package:section08/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:section08/routes/user_products.dart';

void main() {
  runApp(MyShop());
}

class MyShop extends StatelessWidget {
  MyShop({Key? key}) : super(key: key);

  final appTheme = ThemeData(
    primarySwatch: Colors.brown,
    fontFamily: 'Lato',
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: MaterialApp(
        theme: appTheme.copyWith(
          colorScheme: appTheme.colorScheme.copyWith(secondary: Colors.amberAccent),
        ),
        home: const ProductOverviewScreen(),
        // home: const EditProductScreen(),
        routes: {
          ProductOverviewScreen.routeName: ((context) => const ProductOverviewScreen()),
          ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductsScreen.routeName: (context) => const UserProductsScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}
