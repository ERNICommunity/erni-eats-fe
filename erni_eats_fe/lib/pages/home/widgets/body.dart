import 'package:erni_eats_fe/models/models.dart';
import 'package:erni_eats_fe/pages/home/widgets/daily-menu.dart';
import 'package:erni_eats_fe/service/eat11-be.dart';
import 'package:flutter/material.dart';

Widget homeBody() {
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
            // todo displayed toggle
            // if (!establishment.displayed) {
            //   return Column();
            // }
            // todo implement card with extended content
            return Card(
              child: ExpansionTile(
                title: ListTile(
                  // todo show image
                  // trailing: Container(
                  //   height: 80,
                  //   width: 80,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       fit: BoxFit.fill,
                  //       image: AssetImage(establishment.imgUrl),
                  //     ),
                  //     shape: BoxShape.circle,
                  //   ),
                  // ),
                  title: Text(establishment.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      establishment.description != null
                          ? Text('${establishment.description}')
                          : Column(),
                      Row(
                        children: [
                          Row(children: _starsForRating(establishment.rating)),
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
          },
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        );
      }
      return Center();
    },
  );
}

List<Icon> _starsForRating(_rating) {
  List<Icon> stars = [];
  for (int i = 0; i < _rating; i++) {
    stars.add(Icon(
      Icons.star,
      size: 20.0,
      color: Colors.black54,
    ));
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
  return 'Neznáme';
}

void _establishmentPage(Establishment establishment) {
  // todo redirect to establishment detail page
  print('_establishmentPage');
}
