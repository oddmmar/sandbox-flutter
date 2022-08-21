import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:section04/pages/home.dart';

void main(List<String> args) {
  // WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      // DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ],
  );
  debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoApp(
            debugShowCheckedModeBanner: false,
            title: 'Expenses',
            home: SafeArea(
              child: HomePage(),
            ),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: true,
            home: const HomePage(),
            title: 'Expenses',
            theme: ThemeData(
              primarySwatch: Colors.green,
              textTheme: const TextTheme(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                ),
              ),
              fontFamily: 'Quicksand',
              appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
  }
}
