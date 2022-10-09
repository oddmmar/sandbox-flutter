import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavourite = false,
  });

  String? id;
  late String? title;
  late String? description;
  late String? imageUrl;
  late double? price;
  bool isFavourite;

  void _setFaveStatus(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
    // throw const HttpException('Server error. Status unchanged.');
  }

  Future<void> toggleFavouriteStatus() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.parse('https://fluttershopapp-6901d-default-rtdb.firebaseio.com/products/$id.json');
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavourite': isFavourite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFaveStatus(oldStatus);
      }
    } catch (error) {
      _setFaveStatus(oldStatus);
    }
  }
}

// TODO: Check out video 198 about listening to these changes.
