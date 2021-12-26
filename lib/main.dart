import 'package:erni_eats_fe/pages/splash/splash.dart';
import 'package:erni_eats_fe/theme/config.dart';
import 'package:flutter/material.dart';

import 'data/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: currentTheme.currentTheme,
      home: SplashPage(),
    );
  }
}