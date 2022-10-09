import 'dart:io';

import 'package:flutter/cupertino.dart';
// import 'package:section08/dummy_data.dart';
import 'package:section08/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  // bool _showFavouriteOnly = false;

  // ignore: prefer_final_fields
  List<Product> _items = [];

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

  Future<void> fetchAnsSetProducts() async {
    final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) {
          loadedProducts.add(
            Product(
              id: prodId,
              imageUrl: prodData['imageUrl'],
              title: prodData['title'],
              description: prodData['description'],
              isFavourite: prodData['isFavourite'],
              price: prodData['price'],
            ),
          );
        },
      );
      _items = loadedProducts;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavourite': product.isFavourite,
          }));

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }

    notifyListeners();
  }

  Future<void> updateProduct({required String id, required Product newProduct}) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/products/$id.json');
      await http.patch(
        url,
        body: json.encode(
          {
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          },
        ),
      );
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct({required String id}) async {
    final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/products/$id.json');
    final existingProductIndex = _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    // delete returns no error even if one occurs
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      // perform roll back
      _items.insert(existingProductIndex, existingProduct!);
      notifyListeners();
      throw const HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
