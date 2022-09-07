import 'package:flutter/cupertino.dart';
import 'package:section08/dummy_data.dart';
import 'package:section08/providers/product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  // bool _showFavouriteOnly = false;

  // ignore: prefer_final_fields
  List<Product> _items = dummyProducts;

  List<Product> get favouriteItems {
    /// Only return favourite items. New list.
    return _items.where((element) => element.isFavourite).toList();
  }

  List<Product> get items {
    // if (_showFavouriteOnly) {
    //   return _items.where((element) => element.isFavourite).toList();
    // }
    /// Returns a copy of the items and not a pointer / reference
    return [..._items];
  }

  // void showFavouritesOnly() {
  //   _showFavouriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouriteOnly = false;
  //   notifyListeners();
  // }

  Product findById({String? id}) {
    return _items.firstWhere((element) {
      return element.id == id!;
    });
  }

  void addProduct() {
    notifyListeners();
  }
}
