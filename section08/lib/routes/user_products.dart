import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section08/providers/products.dart';
import 'package:section08/routes/edit_product_screen.dart';
import 'package:section08/widgets/app_drawer.dart';
import 'package:section08/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAnsSetProducts(filterByUser: true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context).items;

    return Scaffold(
      drawer: const AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: ''),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Your Products'),
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: Consumer<Products>(
                  builder: (context, productsData, _) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: productsData.items!.length,
                      itemBuilder: (_, index) => ChangeNotifierProvider.value(
                        value: productsData.items![index],
                        // builder: (),
                        child: Column(
                          children: [
                            UserProductItem(
                              id: productsData.items![index].id!,
                              title: productsData.items![index].title!,
                              imageUrl: productsData.items![index].imageUrl!,
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
