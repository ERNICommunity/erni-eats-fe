import 'package:erni_eats_fe/service/mocked-be-data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget homeSidebar() {
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
              future: getRestaurants(),
              initialData: [],
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                  title: Text('Link na github'),
                  onTap: () {
                    // todo show FE and BE github links to be opened in external browser
                  },
                ),
              ],
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
          ],
        )),
  );
}
