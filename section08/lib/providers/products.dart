import 'package:flutter/cupertino.dart';
import 'package:section08/dummy_data.dart';
import 'package:section08/providers/product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = dummyProducts;

  List<Product> get items {
    /// Returns a copy of the items and not a pointer / reference
    return [..._items];
  }

  Product findById({String? id}) {
    return _items.firstWhere((element) {
      return element.id == id!;
    });
  }

  void addProduct() {
    notifyListeners();
  }
}
