import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section08/providers/products.dart';
import 'package:section08/routes/cart_screen.dart';
import 'package:section08/widgets/app_drawer.dart';
import 'package:section08/widgets/badge.dart';
import 'package:section08/widgets/products_grid.dart';
import 'package:section08/providers/cart.dart';

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
  bool _didLoad = false;

  Future<void> _forceRefresh() async {
    _didLoad = false;
    didChangeDependencies();
  }

  @override
  void initState() {
    /* HACK: remember of(context) operations are not available before full initialisation.  */
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAnsSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // this method runs multiple times, this hack is to stop multiple executions.
    if (!_didLoad) {
      setState(() {
        Provider.of<Products>(context, listen: false).fetchAnsSetProducts();
      });
    }
    _didLoad = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // careful not manage changes for just one widget in a global area as the
    // data state will persist through all the screens

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
                const PopupMenuItem(
                  value: FilterOptions.favourites,
                  child: Text('Only Favourites'),
                ),
                const PopupMenuItem(
                  value: FilterOptions.all,
                  child: Text('Show All'),
                ),
              ];
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _forceRefresh(),
        child: ProductsGrid(productsFilter: _showFavouriteOnly),
      ),
    );
  }
}
