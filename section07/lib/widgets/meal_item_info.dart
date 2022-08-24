import 'package:flutter/material.dart';

class MealItemInfo extends StatelessWidget {
  const MealItemInfo({
    Key? key,
    required this.info,
    required this.icon,
  }) : super(key: key);

  final String info;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(info),
      ],
    );
  }
}
