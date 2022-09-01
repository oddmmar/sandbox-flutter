import 'package:flutter/material.dart';
import 'package:section07/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen(
      {Key? key, required this.saveFilters, required this.filters})
      : super(key: key);

  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> filters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.filters['gluten']!;
    _vegetarian = widget.filters['vegetarian']!;
    _vegan = widget.filters['vegan']!;
    _lactoseFree = widget.filters['lactose']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
      {required String label,
      String description = '',
      required bool currentValue,
      required Function(bool) updateValue}) {
    return SwitchListTile(
      title: Text(label),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                  'lactose': _lactoseFree,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  label: 'Gluten-Free',
                  description: 'Show only gluten-free options',
                  currentValue: _glutenFree,
                  updateValue: (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }),
              _buildSwitchListTile(
                  label: 'Vegetarian',
                  description: 'Show only vegetarian options',
                  currentValue: _vegetarian,
                  updateValue: (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }),
              _buildSwitchListTile(
                  label: 'Vegan',
                  description: 'Show only vegan options',
                  currentValue: _vegan,
                  updateValue: (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }),
              _buildSwitchListTile(
                  label: 'Lactose-Free',
                  description: 'Show only lactose-free options',
                  currentValue: _lactoseFree,
                  updateValue: (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }),
            ],
          ))
        ],
      ),
    );
  }
}
