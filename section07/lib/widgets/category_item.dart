import 'package:flutter/material.dart';
import 'package:section07/routes/categories_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.id,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String id;
  final String title;
  final Color color;

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
