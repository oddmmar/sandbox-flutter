import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section08/providers/cart.dart';
import 'package:section08/providers/orders.dart';
import 'package:section08/widgets/listview_cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Chip(
                      label: Text('\$${cart.totalAmount}'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.elements.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                    child: const Text('Order Now'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListViewCartItem(
                  id: cart.elements.values.toList()[index].id,
                  productId: cart.elements.keys.toList()[index],
                  price: cart.elements.values.toList()[index].price,
                  quantity: cart.elements.values.toList()[index].quantity,
                  title: cart.elements.values.toList()[index].title,
                );
              },
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
