import 'package:flutter/foundation.dart';

class CartItem {
  CartItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });

  final String id;
  final String title;
  final int quantity;
  final double price;
}
