// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:section07/routes/categories_screen.dart';

// import 'package:flutter/cupertino.dart';

void main() {
  runApp(const Meals());
}

class Meals extends StatelessWidget {
  const Meals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CategoriesScreen(),
    );
  }
}
