import 'package:flutter/material.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/routes/add_place.dart';
import 'package:places/routes/places_list.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PlacesApp());
}

class PlacesApp extends StatelessWidget {
  const PlacesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GreatPlaces()),
      ],
      child: MaterialApp(
        title: 'Great Places',
        home: const PlacesListScreen(),
        routes: {
          PlacesListScreen.routeName: ((context) => const PlacesListScreen()),
          AddPlacesScreen.routeName: ((context) => const AddPlacesScreen()),
        },
      ),
    );
  }
}
