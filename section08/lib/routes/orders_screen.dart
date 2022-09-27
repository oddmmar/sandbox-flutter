import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section08/providers/orders.dart' show Orders;
import 'package:section08/widgets/app_drawer.dart';
import 'package:section08/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) {
          return OrderItem(order: orderData.orders[index]);
        },
      ),
    );
  }
}
