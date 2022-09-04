import 'package:flutter/material.dart';
import 'package:section08/widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  static const routeName = '/product-overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Shop'),
      ),
      body: const ProductsGrid(),
    );
  }
}
