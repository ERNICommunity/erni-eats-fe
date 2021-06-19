import 'dart:math';

import 'package:erni_eats_fe/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eat11',
      theme: ThemeData(
        primaryColor: Colors.white,
        // primaryColor: Colors.deepOrangeAccent,
        // primarySwatch: getPrimarySwatch(),
      ),
      home: MyHomePage(title: 'Eat11'),
    );
  }
}

MaterialColor getPrimarySwatch() {
  List<MaterialColor> colors = [
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.purple
  ];
  final _random = new Random();
  return colors[_random.nextInt(colors.length)];
}
