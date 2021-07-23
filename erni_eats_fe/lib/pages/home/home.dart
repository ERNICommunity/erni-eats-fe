import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/home/widgets/body.dart';
import 'package:erni_eats_fe/pages/home/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final HomePassedParam passedParam;

  HomePage(this.passedParam);

  @override
  _HomePageState createState() => _HomePageState(this.passedParam);
}

class _HomePageState extends State<HomePage> {
  HomePassedParam passedParam;

  _HomePageState(this.passedParam);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
      ),
      drawer: HomeSidebarWidget(context, passedParam),
      body: HomeBodyWidget(passedParam),
      onDrawerChanged: (bool isOpen) {
        if (!isOpen) {
          _updateHomeParam();
        }
      },
    );
  }

  void _updateHomeParam() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? displayedEstablishmentsPrefs =
        prefs.getStringList(SharedPreferencesKey.DisplayedEstablishments);
    if (displayedEstablishmentsPrefs != null) {
      setState(() {
        passedParam = HomePassedParam(displayedEstablishmentsPrefs);
      });
    }
  }
}
