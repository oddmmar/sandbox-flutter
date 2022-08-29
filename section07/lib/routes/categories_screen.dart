import 'package:flutter/material.dart';
import 'package:section07/dummy_data.dart';
import 'package:section07/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  static const routeName = '/categories=screen';

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 1.8,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      children: dummyCategories.map((categoryData) {
        return CategoryItem(
          id: categoryData.id,
          title: categoryData.title,
          color: categoryData.color,
        );
      }).toList(),
    );
  }
}
