// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:section07/routes/categories_meals_screen.dart';
import 'package:section07/routes/categories_screen.dart';
import 'package:section07/routes/meal_detail_screen.dart';
import 'package:section07/routes/tester_screen.dart';

// import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(Meals());
}

class Meals extends StatelessWidget {
  Meals({Key? key}) : super(key: key);

  final ThemeData appTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
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
      debugShowCheckedModeBanner: false,
      title: 'Meals',
      theme: appTheme.copyWith(
        colorScheme: appTheme.colorScheme.copyWith(secondary: Colors.amber),
        textTheme: appTheme.textTheme.copyWith(
          bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
        ),
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/', // default anyway
      routes: {
        '/': (context) => const TesterScreen(),
        // '/': (context) => const CategoriesScreen(), // optional
        CategoryMealsScreen.routeName: (context) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      // },
      // onUnknownRoute: (settings) {
      //   return const CategoriesScreen() as Route<dynamic>;
      // },
    );
  }
}
