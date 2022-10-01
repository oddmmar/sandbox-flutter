// import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  final String id;
  late final String title;
  late final String description;
  late final String imageUrl;
  late final double price;
  bool isFavourite;

  void toggleFavouriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}

class TempProduct {
  String id = '';
  late String title;
  late String description;
  late String imageUrl;
  late double price;
}

// TODO: Check out video 198 about listening to these changes.
