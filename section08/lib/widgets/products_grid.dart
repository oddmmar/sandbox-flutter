import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:section08/providers/products.dart';
import 'package:section08/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key, required this.productsFilter}) : super(key: key);
  final bool productsFilter;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsFilter ? productsData.favouriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: ((context, index) {
        return ChangeNotifierProvider.value(
          // needs to 'push' notification of changes per grid item
          // create: (context) => products[index],
          value: products[index],
          child: const ProductItem(),
        );
      }),
    );
  }
}
