import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/establishment/widgets/contact-info.dart';
import 'package:erni_eats_fe/shared/widgets/daily-menu.dart';
import 'package:erni_eats_fe/shared/widgets/establishment-summary.dart';
import 'package:erni_eats_fe/pages/establishment/widgets/reviews.dart';
import 'package:erni_eats_fe/utils/launch-url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EstablishmentPage extends StatelessWidget {
  final EstablishmentPagePassedParameters passedParameters;

  EstablishmentPage(this.passedParameters);

  @override
  Widget build(BuildContext context) {
    Establishment establishment = passedParameters.establishment;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.establishmentPage_Title),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          EstablishmentSummaryWidget(establishment),
          ListTile(
              title: Text(AppLocalizations.of(context)!
                  .establishmentPage_LunchMenuSection_Title)),
          DailyMenuWidget(context, establishment),
          ListTile(
              title: Text(AppLocalizations.of(context)!
                  .establishmentPage_FeedbackSection_Title)),
          ReviewsWidget(establishment),
          ListTile(
              title: Text(AppLocalizations.of(context)!
                  .establishmentPage_ContactSection_Title)),
          ContactInfoWidget(establishment),
          TextButton(
            child: Text(AppLocalizations.of(context)!
                .establishment_LunchMenuWeb_Button),
            onPressed: () => launchURL(establishment.dailyMenuUrl),
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!
                .establishment_EstablishmentWeb_Button),
            onPressed: () => launchURL(establishment.websiteUrl),
          ),
        ],
      ),
    );
  }
}
