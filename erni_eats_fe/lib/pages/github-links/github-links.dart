import 'package:erni_eats_fe/utils/launch-url.dart';
import 'package:flutter/material.dart';

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
              onPressed: () => launchURL(_frontendUrl),
            ),
            TextButton(
              child: const Text('Backend aplikácia'),
              onPressed: () => launchURL(_backendUrl),
            ),
          ],
        ),
      ),
    );
  }
}
