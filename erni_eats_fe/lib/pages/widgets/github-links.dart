import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubLinksRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String _title = 'Linky na GitHub';
    String _frontendUrl = 'https://github.com/ERNICommunity/erni-eats-fe';
    String _backendUrl = 'https://github.com/ERNICommunity/erni-eats-be';

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Container(
        padding: new EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('GitHub repozitáre projektu:'),
            ),
            TextButton(
              child: const Text('Frontend aplikácia'),
              onPressed: () => _launchURL(_frontendUrl),
            ),
            TextButton(
              child: const Text('Backend aplikácia'),
              onPressed: () => _launchURL(_backendUrl),
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
