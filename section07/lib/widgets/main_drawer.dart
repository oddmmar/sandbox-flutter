import 'package:flutter/material.dart';
import 'package:section07/routes/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(
      {required String title,
      required IconData icon,
      required Function onTapHandler}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
            // fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: (() => onTapHandler()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 106,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.grey.shade800,
            alignment: Alignment.centerLeft,
            child: Text(
              'Let\'s Cook',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildListTile(
              title: 'Meals',
              icon: Icons.restaurant,
              onTapHandler: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          const SizedBox(height: 10),
          buildListTile(
              title: 'Filters',
              icon: Icons.favorite,
              onTapHandler: () {
                Navigator.of(context)
                    .pushReplacementNamed(FilterScreen.routeName);
              }),
        ],
      ),
    );
  }
}
