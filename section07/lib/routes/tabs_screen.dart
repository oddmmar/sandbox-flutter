import 'package:flutter/material.dart';
import 'package:section07/routes/categories_screen.dart';
import 'package:section07/routes/favourites_screen.dart';
import 'package:section07/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  static const routeName = '/tabs-screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _tabPages = [
    {'page': const CategoriesScreen(), 'title': 'Categories'},
    {'page': const FavouritesScreen(), 'title': 'Favourites'},
  ];

  int _selectedPageIndex = 0;

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
        title: Text(_tabPages[_selectedPageIndex]['title']! as String),
      ),
      body: _tabPages[_selectedPageIndex]['page']! as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedTab,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        // use apps color scheme
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

// tabs withing appbar

// DefaultTabController(
//       initialIndex: 0,
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Meals'),
//           bottom: const TabBar(
//             // indicator: BoxDecoration(color: Colors.blueAccent),
//             indicatorColor: Colors.pink,
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.category),
//                 text: 'Categories',
//               ),
//               Tab(
//                 icon: Icon(Icons.star),
//                 text: 'Favourites',
//               ),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             CategoriesScreen(),
//             FavouritesScreen(),
//           ],
//         ),
//       ),
//     );