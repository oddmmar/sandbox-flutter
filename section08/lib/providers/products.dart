import 'dart:io';

import 'package:flutter/cupertino.dart';
// import 'package:section08/dummy_data.dart';
import 'package:section08/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  Products({
    this.authToken,
    required this.items,
    this.userId,
  });

  final String? authToken;
  final String? userId;
  List<Product>? items = [];

  List<Product> get favouriteItems {
    /// Only return favourite items. New list.
    return items!.where((element) => element.isFavourite).toList();
  }

  List<Product> get itemsCopy {
    // if (_showFavouriteOnly) {
    //   return items.where((element) => element.isFavourite).toList();
    // }
    /// Returns a copy of the items and not a pointer / reference
    return [...items!];
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
    return items!.firstWhere((element) {
      return element.id == id!;
    });
  }

  Future<void> fetchAnsSetProducts({bool filterByUser = false}) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData.isEmpty) return;
      // fetch favourites
      url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken');
      final favouriteResponse = await http.get(url);
      final favouriteData = json.decode(favouriteResponse.body);

      final List<Product> loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) {
          loadedProducts.add(
            Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              // isFavourite: prodData['isFavourite'],
              isFavourite: favouriteData == null ? false : favouriteData[prodId] ?? false,
              price: prodData['price'],
              imageUrl: prodData['imageUrl'],
            ),
          );
        },
      );
      items = loadedProducts;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
            // 'isFavourite': product.isFavourite,
          },
        ),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      items!.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> updateProduct({required String id, required Product newProduct}) async {
    final productIndex = items!.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
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
      items![productIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct({required String id}) async {
    final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    final existingProductIndex = items!.indexWhere((element) => element.id == id);
    Product? existingProduct = items![existingProductIndex];
    items!.removeAt(existingProductIndex);
    notifyListeners();

    // delete returns no error even if one occurs
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      // perform roll back
      items!.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw const HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
