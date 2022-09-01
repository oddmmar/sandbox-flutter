import 'package:flutter/material.dart';
import 'package:section07/models/meal.dart';
import 'package:section07/routes/categories_screen.dart';
import 'package:section07/routes/favourites_screen.dart';
import 'package:section07/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key, required this.faves}) : super(key: key);

  static const routeName = '/';
  final List<Meal> faves;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>>? _tabPages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _tabPages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavouritesScreen(favouriteMeals: widget.faves),
        'title': 'Favourites'
      },
    ];
    super.initState();
  }

  void _selectedTab(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: Text(_tabPages![_selectedPageIndex]['title']! as String),
      ),
      body: _tabPages![_selectedPageIndex]['page']! as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _selectedTab,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
