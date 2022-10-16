import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:section08/models/cart_item.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  OrderItem({
    Key? key,
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });

  final String? id;
  final double? amount;
  final List<CartItem>? products;
  final DateTime? dateTime;
}

class Orders with ChangeNotifier {
  Orders({this.authToken, required this.orders});

  final String? authToken;
  late List<OrderItem>? orders = [];

  List<OrderItem> get ordersCopy {
    return [...orders!];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/orders.json?auth=$authToken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String?, dynamic>?;

    if (extractedData == null) return;
    extractedData.forEach(
      (orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData!['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ),
                )
                .toList(),
          ),
        );
      },
    );
    orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/orders.json?auth=$authToken');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode(
        {
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartItems
              .map((item) => {
                    'id': item.id,
                    'title': item.title,
                    'quantity': item.quantity,
                    'price': item.price,
                  })
              .toList(),
        },
      ),
    );

    orders!.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartItems,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
