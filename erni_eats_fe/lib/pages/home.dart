import 'package:erni_eats_fe/pages/widgets/body.dart';
import 'package:erni_eats_fe/pages/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: homeSidebar(),
      body: homeBody(),
    );
  }
}
