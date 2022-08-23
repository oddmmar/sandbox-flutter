// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:section07/routes/categories_screen.dart';

// import 'package:flutter/cupertino.dart';

void main() {
  runApp(Meals());
}

class Meals extends StatelessWidget {
  Meals({Key? key}) : super(key: key);

  final ThemeData appTheme = ThemeData(
    primarySwatch: Colors.pink,
    canvasColor: const Color.fromRGBO(255, 254, 229, 1),
    fontFamily: 'Raleway',
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontFamily: 'RobotCondensed',
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: appTheme.copyWith(
        colorScheme: appTheme.colorScheme.copyWith(secondary: Colors.amber),
        textTheme: appTheme.textTheme.copyWith(
          bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
        ),
      ),
      home: const CategoriesScreen(),
    );
  }
}
