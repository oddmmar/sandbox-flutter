import 'package:flutter/foundation.dart';
import 'package:section08/models/cart_item.dart';

class Cart with ChangeNotifier {
  // Cart({Key? key});
  Map<String, CartItem>? items = {};

  Map<String, CartItem> get elements {
    return {...items!};
  }

  int get itemCount {
    return items!.length;
  }

  void addItem({required String productId, required double price, required String title}) {
    if (items!.containsKey(productId)) {
      items!.update(
        productId,
        (value) => CartItem(
          id: value.id,
          price: value.price,
          quantity: value.quantity + 1,
          title: value.title,
        ),
      );
    } else {
      items!.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          quantity: 1,
          title: title,
        ),
      );
    }
    notifyListeners();
  }
}
