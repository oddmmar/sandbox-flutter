import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:section07/dummy_data.dart';
import 'package:section07/models/meal.dart';
import 'package:section07/routes/categories_meals_screen.dart';
import 'package:section07/routes/categories_screen.dart';
import 'package:section07/routes/filters_screen.dart';
import 'package:section07/routes/meal_detail_screen.dart';
import 'package:section07/routes/tabs_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(const Meals());
}

class Meals extends StatefulWidget {
  const Meals({Key? key}) : super(key: key);

  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'vegetarian': false,
    'lactose': false,
  };

  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _faveMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = dummyMeals.where((element) {
        if (_filters['gluten']! && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !element.isVegan) {
          return false;
        }
        if (_filters['vegetaria']! && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFaves({required String mealId}) {
    print('toggling');
    final existingIndex =
        _faveMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _faveMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _faveMeals
            .add(dummyMeals.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFave(String id) {
    final bool testCond = _faveMeals.any((element) => element.id == id);
    print(testCond);
    return testCond;
  }

  final ThemeData appTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    primaryColor: Colors.black,
    fontFamily: 'SFPro',
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
        '/': (context) => TabsScreen(faves: _faveMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        CategoriesScreen.routeName: ((context) => const CategoriesScreen()),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
              toggleFave: _toggleFaves,
              isMealFave: _isMealFave,
            ),
        FilterScreen.routeName: ((context) =>
            FilterScreen(filters: _filters, saveFilters: _setFilters)),
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
