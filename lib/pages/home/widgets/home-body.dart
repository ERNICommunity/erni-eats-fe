import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/establishment/establishment.dart';
import 'package:erni_eats_fe/pages/home/widgets/daily-menu.dart';
import 'package:erni_eats_fe/service/http-service.dart';
import 'package:flutter/material.dart';

import 'establishment-summary.dart';

class HomeBodyWidget extends StatefulWidget {
  final HomePagePassedParameters passedParameters;

  HomeBodyWidget(this.passedParameters);

  @override
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllEstablishments(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.grey),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            snapshot.data.length > 0) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Establishment establishment = snapshot.data[index];
              if (!widget.passedParameters.displayedEstablishments
                  .contains(establishment.id)) {
                return Column();
              }
              return _getExpansionCardWidget(establishment);
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          );
        }
        return Center(
          child: Text("Bohužiaľ, sa nepodarilo načítať reštaurácie."),
        );
      },
    );
  }

  Widget _getExpansionCardWidget(Establishment establishment) {
    return Card(
      child: ExpansionTile(
        title: EstablishmentSummaryWidget(establishment),
        children: [
          DailyMenuWidget(context, establishment),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              child: Text('Zistiť viac'),
              onPressed: () =>
                  _navigateToEstablishmentPage(context, establishment),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 16)),
            ),
          ),
        ],
        expandedAlignment: Alignment.topLeft,
        textColor: Colors.black,
      ),
    );
  }
}

void _navigateToEstablishmentPage(context, Establishment establishment) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => EstablishmentPage(
            EstablishmentPagePassedParameters(establishment))),
  );
}
