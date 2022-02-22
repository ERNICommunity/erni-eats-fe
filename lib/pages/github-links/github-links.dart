import 'package:erni_eats_fe/utils/launch-url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GithubLinksRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _title = AppLocalizations.of(context)!.gitHubLinkPage_Title;
    String _frontendUrl = 'https://github.com/ERNICommunity/erni-eats-fe';
    String _backendUrl = 'https://github.com/ERNICommunity/erni-eats-be';

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Container(
        alignment: Alignment.center,
        padding: new EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(AppLocalizations.of(context)!.gitHubLinkPage_Header),
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!
                  .gitHubLinkPage_FrontendRepository_Label),
              onPressed: () => launchURL(_frontendUrl),
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!
                  .gitHubLinkPage_BackendRepository_Label),
              onPressed: () => launchURL(_backendUrl),
            ),
          ],
        ),
      ),
    );
  }
}
