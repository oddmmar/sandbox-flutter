import 'package:flutter/cupertino.dart';
import 'package:section08/dummy_data.dart';
import 'package:section08/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> addProduct(Product product) {
    final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/products.json');
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'isFavourite': product.isFavourite,
            }))
        .then((response) {
      // print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.insert(0, newProduct);
    });
    notifyListeners();
  }

  void updateProduct({required String id, required Product newProduct}) {
    final productIndex = _items.indexWhere((element) => element.id == id);
    _items[productIndex] = newProduct;
    notifyListeners();
  }

  void deleteProduct({required String id}) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
