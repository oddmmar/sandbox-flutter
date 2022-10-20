import 'package:flutter/material.dart';
import 'package:section08/providers/auth.dart';
import 'package:section08/providers/cart.dart';
import 'package:section08/providers/orders.dart';
import 'package:section08/routes/auth_screen.dart';
import 'package:section08/routes/cart_screen.dart';
import 'package:section08/routes/edit_product_screen.dart';
import 'package:section08/routes/orders_screen.dart';
import 'package:section08/routes/product_detail_screen.dart';
import 'package:section08/routes/products_overview_screen.dart';
import 'package:section08/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:section08/routes/splash_screen_dart.dart';
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
        ChangeNotifierProvider(create: (context) => Auth()), // import that this comes first
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(items: []),
          update: (context, auth, previous) => Products(
            authToken: auth.token,
            userId: auth.userId,
            items: previous!.items == null ? [] : previous.items,
          ),
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(orders: [], userId: '', authToken: ''),
          update: (context, auth, previous) => Orders(
            authToken: auth.token,
            userId: auth.userId,
            orders: previous!.orders == null ? [] : previous.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          theme: appTheme.copyWith(
            colorScheme: appTheme.colorScheme.copyWith(secondary: Colors.amberAccent),
          ),
          home: auth.isAuth
              ? const ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? const SplashScreen() : const AuthScreen(),
                ),
          // home: const EditProductScreen(),
          routes: {
            ProductOverviewScreen.routeName: ((context) => const ProductOverviewScreen()),
            ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrdersScreen.routeName: (context) => const OrdersScreen(),
            UserProductsScreen.routeName: (context) => const UserProductsScreen(),
            EditProductScreen.routeName: (context) => const EditProductScreen(),
            AuthScreen.routeName: (context) => const AuthScreen(),
          },
        ),
      ),
    );
  }
}
