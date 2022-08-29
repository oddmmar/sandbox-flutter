// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:section07/routes/categories_meals_screen.dart';
import 'package:section07/routes/categories_screen.dart';
import 'package:section07/routes/filter_screen.dart';
import 'package:section07/routes/meal_detail_screen.dart';
import 'package:section07/routes/tabs_screen.dart';

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
    primaryColor: Colors.black,
    fontFamily: 'SFPro',
    // textTheme: TextTheme(
    //   titleMedium: const TextStyle(
    //     fontSize: 17,
    //   ),
    //   bodyText1: const TextStyle(
    //     fontSize: 30,
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals',
      theme: appTheme.copyWith(
        colorScheme: appTheme.colorScheme.copyWith(
          secondary: Colors.amber,
          primary: Colors.black,
        ),
        textTheme: appTheme.textTheme.copyWith(
          bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
        ),
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/', // default anyway
      routes: {
        '/': (context) => const TabsScreen(),
        CategoryMealsScreen.routeName: (context) => const CategoryMealsScreen(),
        CategoriesScreen.routeName: ((context) => const CategoriesScreen()),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
        FilterScreen.routeName: ((context) => const FilterScreen()),
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
