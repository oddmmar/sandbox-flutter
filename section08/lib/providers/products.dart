import 'package:flutter/cupertino.dart';
import 'package:section08/dummy_data.dart';
import 'package:section08/models/product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = dummyProducts;

  List<Product> get items {
    /// Returns a copy of the items and not a pointer / reference
    return [..._items];
  }
}
