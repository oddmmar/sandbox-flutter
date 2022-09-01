import 'package:flutter/material.dart';
import 'package:section07/widgets/meal_item.dart';

import '../models/meal.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key, required this.favouriteMeals})
      : super(key: key);

  static const routeName = '/favourites-screen';
  final List<Meal> favouriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return const Center(
        child: Text('No favourites'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctc, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            complexity: favouriteMeals[index].complexity,
            affordability: favouriteMeals[index].affordability,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
