import 'package:flutter/material.dart';
import 'package:section08/providers/cart.dart';
import 'package:section08/routes/cart_screen.dart';
import 'package:section08/routes/product_detail_screen.dart';
import 'package:section08/routes/products_overview_screen.dart';
import 'package:section08/providers/products.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MaterialApp(
        theme: appTheme.copyWith(
          colorScheme: appTheme.colorScheme.copyWith(secondary: Colors.amberAccent),
        ),
        home: const ProductOverviewScreen(),
        routes: {
          ProductOverviewScreen.routeName: ((context) => const ProductOverviewScreen()),
          ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
        },
      ),
    );
  }
}
