import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(
            width: double.infinity,
            child: Card(
              color: Colors.amber,
              child: Text('Chart'),
            ),
          ),
          Card(
            child: Text('List if transactions'),
          )
        ],
      ),
    );
  }
}
