import 'package:flutter/material.dart';
import 'package:section08/routes/products_overview_screen.dart';

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
    return MaterialApp(
      theme: appTheme.copyWith(
        colorScheme:
            appTheme.colorScheme.copyWith(secondary: Colors.amberAccent),
      ),
      home: ProductOverviewScreen(),
    );
  }
}
