import 'package:flutter/material.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MOBILE')),
      body: Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.red,
        ),
      ),
    );
  }
}
