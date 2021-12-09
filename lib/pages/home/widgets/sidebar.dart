import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/donate/donate.dart';
import 'package:erni_eats_fe/pages/github-links/github-links.dart';
import 'package:erni_eats_fe/service/http-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSidebarWidget extends StatefulWidget {
  final BuildContext context;
  final HomePagePassedParameters passedParameters;

  HomeSidebarWidget(this.context, this.passedParameters);

  @override
  _HomeSidebarWidgetState createState() => _HomeSidebarWidgetState(
      this.context, this.passedParameters.displayedEstablishments);
}

class _HomeSidebarWidgetState extends State<HomeSidebarWidget> {
  final BuildContext context;
  List<String> displayedEstablishments;

  _HomeSidebarWidgetState(this.context, this.displayedEstablishments);

  @override
  void initState() {
    super.initState();
  }

  updateDisplayedEstablishments(List<String> newDisplayedEstablishments) {
    setState(() {
      displayedEstablishments = List.castFrom(displayedEstablishments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             HomePage(displayedEstablishments)));
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
                  return _getEstablishmentsListWidget(snapshot);
                }
                return Center(
                  child: Text("Bohužiaľ, sa nepodarilo načítať reštaurácie."),
                );
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
                  onTap: () => _navigateToDonatePage(context, 'Kúpte nám kávu'),
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
        ),
      ),
    );
  }

  Widget _getEstablishmentsListWidget(snapshot) {
    return ListView.builder(
      // todo change restaurant order
      // todo show restaurants in order
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Establishment establishment = snapshot.data[index];
        bool checked = displayedEstablishments.contains(establishment.id);
        return CheckboxListTile(
          title: Text(establishment.name),
          value: checked,
          activeColor: Colors.black54,
          onChanged: (bool? value) async =>
              _onCheckboxChange(checked, establishment.id),
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }

  Future<void> _onCheckboxChange(bool checked, String establishmentId) async {
    List<String> newDisplayedEstablishments =
        List.castFrom(displayedEstablishments);
    if (checked) {
      newDisplayedEstablishments.remove(establishmentId);
    } else {
      newDisplayedEstablishments.add(establishmentId);
    }

    updateDisplayedEstablishments(newDisplayedEstablishments);

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(SharedPreferencesKey.DisplayedEstablishments,
        newDisplayedEstablishments);
  }
}

void _navigateToGitHubLinksPage(context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => GithubLinksRoute()),
  );
}

void _navigateToDonatePage(context, title) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DonateRoute()),
  );
}
