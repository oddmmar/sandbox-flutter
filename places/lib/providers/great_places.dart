import 'package:flutter/foundation.dart';
import 'package:places/models/place.dart';

class GreatPlaces extends ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get places {
    return [..._items];
  }
}
