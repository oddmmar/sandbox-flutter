import 'package:flutter/material.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/routes/add_place.dart';
import 'package:provider/provider.dart';

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
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndsetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                // child is the static widget => ch
                child: const Center(
                  child: Text('No places yet. Add some.'),
                ),
                builder: (context, greatPlaces, ch) =>
                    greatPlaces.places.isEmpty
                        ? ch!
                        : ListView.builder(
                            itemCount: greatPlaces.places.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.places[index].image),
                              ),
                              title: Text(greatPlaces.places[index].title),
                              onTap: (() {}),
                            ),
                          ),
              ),
      ),
    );
  }
}
