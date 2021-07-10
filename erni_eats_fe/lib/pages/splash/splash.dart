import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/home/home.dart';
import 'package:erni_eats_fe/service/util-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<String> displayedEstablishments = [];

  @override
  void initState() {
    super.initState();
    _fetchPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // todo add splash image
      child: CircularProgressIndicator(),
    );
  }

  _fetchPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? displayedEstablishmentsPrefs =
        prefs.getStringList(SharedPreferencesKey.DisplayedEstablishments);
    if (displayedEstablishmentsPrefs == null) {
      List<String> allEstablishmentIds = await getEstablishmentIds();
      prefs.setStringList(
          SharedPreferencesKey.DisplayedEstablishments, allEstablishmentIds);
      setState(() {
        displayedEstablishments = allEstablishmentIds;
      });
    } else {
      setState(() {
        displayedEstablishments = displayedEstablishmentsPrefs;
      });
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePage(HomePassedParam(this.displayedEstablishments))));
  }
}
