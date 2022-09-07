import 'package:flutter/material.dart';
import 'package:section08/widgets/products_grid.dart';

enum FilterOptions {
  favourites,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  static const routeName = '/product-overview';

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavouriteOnly = false;
  @override
  Widget build(BuildContext context) {
    // careful not manage changes for just one widget in a global area as the
    // data state will persist through all the screens

    // final productsContainer = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions.favourites) {
                  _showFavouriteOnly = true;
                  // productsContainer.showFavouritesOnly();
                } else {
                  _showFavouriteOnly = false;
                  // productsContainer.showAll();
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) {
              return [
                const PopupMenuItem(value: FilterOptions.favourites, child: Text('Only Favourites')),
                const PopupMenuItem(value: FilterOptions.all, child: Text('Show All')),
              ];
            },
          )
        ],
      ),
      body: ProductsGrid(productsFilter: _showFavouriteOnly),
    );
  }
}
