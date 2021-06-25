import 'package:erni_eats_fe/models/models.dart';
import 'package:erni_eats_fe/pages/github-links/github-links.dart';
import 'package:erni_eats_fe/service/mocked-be-data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget homeSidebar(BuildContext context) {
  return Drawer(
    child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              pinned: true,
              title: new Text('Nastavenia'),
            ),
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Zobrazené reštaurácie'),
            ),
            FutureBuilder(
              future: getRestaurantsData(),
              initialData: [],
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                // todo implement if-case for ConnectionState.waiting (show spinner)
                // todo implement if-case for ConnectionState.none (show message)
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data.length > 0) {
                  return ListView.builder(
                    // todo change restaurant order
                    // todo show restaurants in order
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Restaurant restaurant = snapshot.data[index];
                      return CheckboxListTile(
                        title: Text(restaurant.title),
                        value: restaurant.displayed,
                        activeColor: Colors.black54,
                        onChanged: (bool? value) {
                          // todo enable restaurants display toggle
                          // todo store locally restaurants display
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  );
                }
                return Column();
              },
            ),
            ListTile(
              title: Text('Ďalšie možnosti'),
            ),
            ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.favorite, color: Colors.black54),
                  title: Text('Kúpte nám kávu'),
                  onTap: () {
                    // todo add donate feature
                  },
                ),
                ListTile(
                  leading: Icon(Icons.message, color: Colors.black54),
                  title: Text('Spätná väzba'),
                  onTap: () {
                    // todo feedback page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.code, color: Colors.black54),
                  title: Text('Link na GitHub'),
                  onTap: () => _navigateToGitHubLinksPage(context),
                ),
              ],
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
          ],
        )),
  );
}

void _navigateToGitHubLinksPage(context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => GithubLinksRoute()),
  );
}
