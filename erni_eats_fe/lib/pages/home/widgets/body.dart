import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/home/widgets/daily-menu.dart';
import 'package:erni_eats_fe/service/http-service.dart';
import 'package:flutter/material.dart';

class HomeBodyWidget extends StatefulWidget {
  final HomePassedParam passedParam;

  HomeBodyWidget(this.passedParam);

  @override
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllEstablishments(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // todo implement if-case for ConnectionState.waiting (show spinner)
          return Column();
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == null) {
          // todo implement if-case for ConnectionState.none (show message)
          return Column();
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data.length > 0) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Establishment establishment = snapshot.data[index];
              if (!widget.passedParam.displayedEstablishments
                  .contains(establishment.id)) {
                return Column();
              }
              return _getExpansionCardWidget(establishment);
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          );
        }
        return Center();
      },
    );
  }

  Widget _getExpansionCardWidget(Establishment establishment) {
    return Card(
      child: ExpansionTile(
        title: ListTile(
          // todo show image
          // leading: _getLogoWidget(establishment),
          title: Text(establishment.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              establishment.description != null
                  ? Text('${establishment.description}')
                  : Column(),
              Row(
                children: [
                  Row(
                      children:
                      _starsForRating(establishment.rating)),
                  Text('(${establishment.userRatingsTotal})'),
                ],
              ),
              Text(
                  '${_getPriceLevel(establishment.priceLevel)} • ${_getEstablishmentType(establishment.type)}'),
            ],
          ),
        ),
        children: [
          DailyMenuWidget(context, establishment),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              child: Text('Zistiť viac'),
              onPressed: () => _establishmentPage(establishment),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 16)),
            ),
          ),
        ],
        expandedAlignment: Alignment.topLeft,
        textColor: Colors.black,
      ),
    );
  }

  Widget _getLogoWidget(Establishment establishment) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          // todo get establishment logo
          image: NetworkImage(''),
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}

List<Icon> _starsForRating(_rating) {
  num roundedToHalfRating = double.parse((_rating * 2).toStringAsFixed(0)) / 2;
  bool ratingWithHalf = roundedToHalfRating * 10 % 10 == 5;

  List<Icon> stars = [];
  for (int i = 0; i < 5; i++) {
    bool halfStarIteration = i + 1 == _rating.round() % 10;
    if (ratingWithHalf && halfStarIteration) {
      stars.add(Icon(
        Icons.star_half,
        size: 20.0,
        color: Colors.black54,
      ));
    } else if (i < roundedToHalfRating) {
      stars.add(Icon(
        Icons.star,
        size: 20.0,
        color: Colors.black54,
      ));
    } else {
      stars.add(Icon(
        Icons.star_border,
        size: 20.0,
        color: Colors.black54,
      ));
    }
  }
  return stars;
}

String _getPriceLevel(_priceLevel) {
  var multiply;
  switch (_priceLevel) {
    case EstablishmentPriceLevel.Inexpensive:
      multiply = 1;
      break;
    case EstablishmentPriceLevel.Moderate:
      multiply = 2;
      break;
    default:
      multiply = 0;
  }
  return '${'€' * multiply}';
}

String _getEstablishmentType(_type) {
  if (_type == EstablishmentType.Restaurant) {
    return 'Reštaurácia';
  }
  if (_type == EstablishmentType.Pub) {
    return 'Pohostinstvo';
  }
  return '';
}

void _establishmentPage(Establishment establishment) {
  // todo redirect to establishment detail page
  print('_establishmentPage');
}
