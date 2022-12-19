import 'package:flutter/material.dart';
import 'package:responsive/routes/homepage.dart';

void main() {
  runApp(const Responsiveness());
}

class Responsiveness extends StatelessWidget {
  const Responsiveness({super.key});
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: HomePage(),
    );
  }
}
