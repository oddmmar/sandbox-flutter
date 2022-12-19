import 'package:flutter/material.dart';

class TabletBody extends StatelessWidget {
  const TabletBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TABLET')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              color: Colors.red,
            ),
            Container(
              height: 100.0,
              width: 100.0,
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
