import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/home/widgets/home-body.dart';
import 'package:erni_eats_fe/pages/home/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final HomePagePassedParameters passedParameters;

  HomePage(this.passedParameters);

  @override
  _HomePageState createState() => _HomePageState(this.passedParameters);
}

class _HomePageState extends State<HomePage> {
  HomePagePassedParameters passedParameters;

  _HomePageState(this.passedParameters);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
      ),
      drawer: HomeSidebarWidget(context, passedParameters),
      body: HomeBodyWidget(passedParameters),
      onDrawerChanged: (bool isOpen) {
        if (!isOpen) {
          _updateHomeParameters();
        }
      },
    );
  }

  void _updateHomeParameters() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? displayedEstablishmentsPrefs =
        prefs.getStringList(SharedPreferencesKey.DisplayedEstablishments);
    if (displayedEstablishmentsPrefs != null) {
      setState(() {
        passedParameters =
            HomePagePassedParameters(displayedEstablishmentsPrefs);
      });
    }
  }
}
