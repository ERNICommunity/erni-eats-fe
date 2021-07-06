import 'package:erni_eats_fe/models/models.dart';
import 'package:erni_eats_fe/service/eat11-be.dart';
import 'package:erni_eats_fe/utils/launch-url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget dailyMenu(BuildContext context, Establishment establishment) {
  return FutureBuilder(
      future: _getDailyMenuRepresentationMap(establishment.id),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          return _getErrorWidget(establishment.websiteUrl);
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == null) {
          return _getErrorWidget(establishment.websiteUrl);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          List<DailyMenu> soups = snapshot.data[DailyMenuItemType.Soup];
          List<DailyMenu> mainDish = snapshot.data[DailyMenuItemType.MainDish];
          if (soups.isEmpty && mainDish.isEmpty) {
            return _getErrorWidget(establishment.websiteUrl);
          }
          return Padding(
            child: ListView(
              children: [
                _getDailyMenuWidget(context, soups, 'Polievky'),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Divider(),
                ),
                _getDailyMenuWidget(context, mainDish, 'Hlavné jedla'),
                // todo switch between days
                // todo handle weekends
                // todo handle holidays
              ],
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          );
        }
        return Center();
      });
}

Future<Map<String, List<DailyMenu>>> _getDailyMenuRepresentationMap(
    String establishmentId) async {
  try {
    Map<String, List<DailyMenu>> representation = {
      DailyMenuItemType.Soup: [],
      DailyMenuItemType.MainDish: [],
    };
    List<DailyMenu> dailyMenu = await getDailyMenu(establishmentId);
    dailyMenu.forEach((element) {
      if (element.type == DailyMenuItemType.Soup) {
        representation[DailyMenuItemType.Soup]!.add(element);
      }
      if (element.type == DailyMenuItemType.MainDish) {
        representation[DailyMenuItemType.MainDish]!.add(element);
      }
    });
    return representation;
  } on Exception {
    throw Exception;
    // todo custom exceptions
  }
}

Widget _getDailyMenuWidget(
    BuildContext context, List<DailyMenu> dailyMenuItems, String title) {
  return Column(
    children: [
      Padding(
        child: Text(title, style: Theme.of(context).textTheme.subtitle1),
        padding: EdgeInsets.only(bottom: 8),
      ),
      dailyMenuItems.isEmpty
          ? _getEmptyMenuWidget()
          : _getDailyMenuItemsWidget(dailyMenuItems),
    ],
    crossAxisAlignment: CrossAxisAlignment.start,
  );
}

Widget _getEmptyMenuWidget() {
  return Text('Nie sú stravy z danej kategórie.');
}

Widget _getDailyMenuItemsWidget(List<DailyMenu> dailyMenuItems) {
  return ListView.builder(
    itemCount: dailyMenuItems.length,
    itemBuilder: (context, index) {
      return Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dailyMenuItems[index].name),
              dailyMenuItems[index].price != null
                  ? Text(dailyMenuItems[index].price.toString())
                  : Text('—'),
            ],
          ));
    },
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
  );
}

Widget _getErrorWidget(String establishmentUrl) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    child: Column(
      children: [
        Text('Nepodarilo sa nájsť menu.'),
        TextButton(
          child: const Text('Prejsť na stránku podniku'),
          onPressed: () => launchURL(establishmentUrl),
        ),
      ],
    ),
  );
}
