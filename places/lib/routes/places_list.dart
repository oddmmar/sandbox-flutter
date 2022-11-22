import 'package:flutter/material.dart';
import 'package:places/routes/add_place.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});
  static const routeName = '/places-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
            icon: const Icon(
              Icons.add,
              size: 30.0,
            ),
          )
        ],
      ),
      body: const Center(
          // child: CircularProgressIndicator(),
          ),
    );
  }
}
