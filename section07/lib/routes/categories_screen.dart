import 'package:flutter/material.dart';
import 'package:section07/dummy_data.dart';
import 'package:section07/widgets/category/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meals',
          // style: ,
        ),
      ),
      body: Center(
        child: GridView(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          children: dummyCategories.map((categoryData) {
            return CategoryItem(
              title: categoryData.title,
              color: categoryData.color,
            );
          }).toList(),
        ),
      ),
    );
  }
}
