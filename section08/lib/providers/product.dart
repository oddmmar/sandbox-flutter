// import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

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

  void toggleFavouriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}

// TODO: Check out video 198 about listening to these changes.
