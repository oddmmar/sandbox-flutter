import 'package:flutter/material.dart';
import 'package:section07/widgets/main_drawer.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  static const routeName = '/filters';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(),
      body: const Center(
        child: Text('Filters'),
      ),
    );
  }
}
