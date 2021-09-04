import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/home/widgets/daily-menu.dart';
import 'package:erni_eats_fe/pages/home/widgets/establishment-summary.dart';
import 'package:erni_eats_fe/utils/launch-url.dart';
import 'package:flutter/material.dart';

class EstablishmentPage extends StatelessWidget {
  final EstablishmentPagePassedParameters passedParameters;

  EstablishmentPage(this.passedParameters);

  @override
  Widget build(BuildContext context) {
    Establishment establishment = passedParameters.establishment;
    return Scaffold(
      appBar: AppBar(
        title: Text(establishment.name),
      ),
      body: EstablishmentPageWidget(establishment),
    );
  }
}

class EstablishmentPageWidget extends StatelessWidget {
  final Establishment establishment;

  EstablishmentPageWidget(this.establishment);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EstablishmentSummaryWidget(establishment),
        ListTile(title: Text('Denné obedové menu')),
        DailyMenuWidget(context, establishment),
        ListTile(title: Text('Recenzie')),
        // todo
        ListTile(title: Text('Kontakt')),
        // todo
        TextButton(
          child: const Text('Denné menu na stránke podniku'),
          onPressed: () => launchURL(establishment.dailyMenuUrl),
        ),
        TextButton(
          child: const Text('Stránka podniku'),
          onPressed: () => launchURL(establishment.websiteUrl),
        ),
      ],
    );
  }
}