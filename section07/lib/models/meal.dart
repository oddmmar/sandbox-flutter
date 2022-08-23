enum Complexity { simple, challenging, hard }

enum Affordability { affordable, pricey, luxurious }

class Meal {
  const Meal(
      {required this.id,
      required this.categories,
      required this.title,
      this.imageUrl =
          'https://www.flaticon.com/free-icon/lunch-box_1205755?term=meal&page=1&position=10&page=1&position=10&related_id=1205755&origin=search',
      required this.ingredients,
      required this.steps,
      required this.duration,
      this.complexity = Complexity.simple,
      this.affordability = Affordability.affordable,
      required this.isGlutenFree,
      required this.isLactoseFree,
      required this.isVegan,
      required this.isVegetarian});

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isVegan;
  final bool isLactoseFree;
  final bool isGlutenFree;
  final bool isVegetarian;
}
