import 'package:flutter/foundation.dart';
import 'package:section08/models/cart_item.dart';

class Cart with ChangeNotifier {
  // Cart({Key? key});

  Map<String, CartItem>? _items;

  Map<String, CartItem> get items {
    return {..._items!};
  }

  void addItem({required String productId, required double price, required String title}) {
    if (_items!.containsKey(productId)) {
      _items!.update(
        productId,
        (value) => CartItem(
          id: value.id,
          price: value.price,
          quantity: value.quantity + 1,
          title: value.title,
        ),
      );
    } else {
      _items!.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          quantity: 1,
          title: title,
        ),
      );
    }
  }
}
