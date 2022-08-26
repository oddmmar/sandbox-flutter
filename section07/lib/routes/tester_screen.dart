import 'package:flutter/material.dart';

class TesterScreen extends StatefulWidget {
  const TesterScreen({Key? key}) : super(key: key);

  @override
  State<TesterScreen> createState() => _TesterScreenState();
}

class _TesterScreenState extends State<TesterScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tester Screen'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 300,
                  height: 20,
                  color: Colors.red,
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: Container(
                    color: Colors.blue,
                    height: 50,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black12,
                  child: Row(
                    children: [
                      Container(
                        color: Colors.amber,
                        height: 60,
                        width: 60,
                      ),
                      Container(
                        color: const Color.fromARGB(255, 149, 123, 43),
                        height: 60,
                        width: 60,
                      ),
                      // Container(
                      //   color: Color.fromARGB(255, 91, 6, 203),
                      //   height: 60,
                      //   width: 60,
                      // ),
                      Container(
                        color: Color.fromARGB(255, 255, 128, 1),
                        height: 60,
                        width: 60,
                      ),
                      Expanded(
                        child: Container(
                          color: Color.fromARGB(255, 12, 238, 110),
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
