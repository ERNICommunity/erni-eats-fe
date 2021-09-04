import 'package:erni_eats_fe/data/data.dart';
import 'package:flutter/material.dart';

class EstablishmentSummaryWidget extends StatelessWidget {
  final Establishment establishment;

  EstablishmentSummaryWidget(this.establishment);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
              Row(children: _starsForRating(establishment.rating)),
              Text('(${establishment.userRatingsTotal})'),
            ],
          ),
          Text(
              '${_getPriceLevel(establishment.priceLevel)} • ${_getEstablishmentType(establishment.type)}'),
        ],
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

  List<Icon> _starsForRating(_rating) {
    num roundedToHalfRating =
        double.parse((_rating * 2).toStringAsFixed(0)) / 2;
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
}
