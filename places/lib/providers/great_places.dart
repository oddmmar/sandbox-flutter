import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:places/handlers/db_interface.dart';
import 'package:places/models/place.dart';

class GreatPlaces extends ChangeNotifier {
  final _dbHander = DbHandler();
  List<Place> _items = [];

  List<Place> get places {
    return [..._items];
  }

  void addPlace({required String imageTitle, required File pickedImage}) {
    final newLoc = PlaceLocation(
      latitude: 0.0,
      longitude: 0.0,
      address: 'Not a place',
    );
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: imageTitle,
        image: pickedImage,
        location: newLoc);
    _items.add(newPlace);
    notifyListeners();
    _dbHander.insert(table: 'user_places', data: {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndsetPlaces() async {
    final dataList = await _dbHander.getData(table: 'user_places');
    final tempPl = PlaceLocation(latitude: 0.0, longitude: 0.0, address: '');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            location: tempPl,
            image: File(e['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
