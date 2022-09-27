import 'package:flutter/foundation.dart';
import 'package:section08/models/cart_item.dart';

class OrderItem {
  OrderItem({
    Key? key,
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });

  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
}

class Orders with ChangeNotifier {
  late final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItems, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartItems,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
