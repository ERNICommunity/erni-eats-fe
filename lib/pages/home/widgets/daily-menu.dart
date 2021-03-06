import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/service/util-service.dart';
import 'package:erni_eats_fe/utils/launch-url.dart';
import 'package:flutter/material.dart';

class DailyMenuWidget extends StatefulWidget {
  final BuildContext context;
  final Establishment establishment;

  DailyMenuWidget(this.context, this.establishment);

  @override
  _DailyMenuWidgetState createState() =>
      _DailyMenuWidgetState(this.context, this.establishment);
}

class _DailyMenuWidgetState extends State<DailyMenuWidget> {
  final BuildContext context;
  final Establishment establishment;

  _DailyMenuWidgetState(this.context, this.establishment);

  DateTime selectedDate = new DateTime.now();
  String selectedDateRepresentation = '';
  Future<Map<String, List<DailyMenu>>> dailyMenuRepresentationMap =
      Future.value(new Map());

  @override
  initState() {
    super.initState();
    selectedDate = new DateTime.now();
    selectedDateRepresentation = '${selectedDate.year.toString()}'
        '-${selectedDate.month.toString().padLeft(2, '0')}'
        '-${selectedDate.day.toString().padLeft(2, '0')}';
    dailyMenuRepresentationMap = getDailyMenuRepresentationMap(
        establishment.id, selectedDateRepresentation);
  }

  @override
  Widget build(BuildContext context) {
    return ReRunnableFutureBuilder(
        establishment, selectedDateRepresentation, dailyMenuRepresentationMap,
        onRerun: _runFeature);
  }

  void _runFeature() {
    setPreviousMenuDate();
    updateDailyMenu();
  }

  void setPreviousMenuDate() {
    setState(() {
      selectedDate = selectedDate.subtract(Duration(days: 1));
      selectedDateRepresentation = '${selectedDate.year.toString()}'
          '-${selectedDate.month.toString().padLeft(2, '0')}'
          '-${selectedDate.day.toString().padLeft(2, '0')}';
    });
  }

  void setNextMenuDate() {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: 1));
      selectedDateRepresentation = '${selectedDate.year.toString()}'
          '-${selectedDate.month.toString().padLeft(2, '0')}'
          '-${selectedDate.day.toString().padLeft(2, '0')}';
    });
  }

  void updateDailyMenu() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        dailyMenuRepresentationMap = getDailyMenuRepresentationMap(
            establishment.id, selectedDateRepresentation);
      });
    });
  }
}

class ReRunnableFutureBuilder extends StatelessWidget {
  final Establishment establishment;
  final String selectedDateRepresentation;
  final Future dailyMenuRepresentationMap;
  final Function onRerun;

  ReRunnableFutureBuilder(this.establishment, this.selectedDateRepresentation,
      this.dailyMenuRepresentationMap,
      {required this.onRerun});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dailyMenuRepresentationMap,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CircularProgressIndicator(color: Colors.grey),
          );
        }
        if (snapshot.hasError) {
          return _getNotFoundWidget(establishment);
        }
        List<DailyMenu> soups = snapshot.data[DailyMenuItemType.Soup];
        List<DailyMenu> mainDish = snapshot.data[DailyMenuItemType.MainDish];
        if (soups.isEmpty && mainDish.isEmpty) {
          return _getNotFoundWidget(establishment);
        }
        return Padding(
          child: ListView(
            children: [
              _getDailyMenuWidget(context, soups, 'Polievky'),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Divider(),
              ),
              _getDailyMenuWidget(context, mainDish, 'Hlavn?? jedla'),
              // todo handle weekends
              // todo handle holidays
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => onRerun(),
                  ),
                  Text(this.selectedDateRepresentation),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => onRerun(),
                  ),
                ],
              ),
            ],
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          ),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        );
      },
    );
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
  return Text('Nie s?? stravy z danej kateg??rie.');
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
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(dailyMenuItems[index].name),
            ),
            dailyMenuItems[index].price != null
                ? Text(dailyMenuItems[index].price.toString())
                : Text('???'),
          ],
        ),
      );
    },
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
  );
}

Widget _getNotFoundWidget(Establishment establishment) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 24),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text('Nepodarilo sa n??js?? menu.'),
        ),
        TextButton(
          child: const Text('Denn?? menu na str??nke podniku'),
          onPressed: () => launchURL(establishment.dailyMenuUrl),
        ),
        TextButton(
          child: const Text('Str??nka podniku'),
          onPressed: () => launchURL(establishment.websiteUrl),
        ),
      ],
    ),
  );
}
