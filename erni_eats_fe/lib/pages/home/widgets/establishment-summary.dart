import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/home/widgets/stars-estimation.dart';
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
              ? Text('${establishment.description}', style: TextStyle(color: Colors.black))
              : Column(),
          StarsEstimation(establishment.rating, establishment.userRatingsTotal),
          Text(
            '${_getPriceLevel(establishment.priceLevel)}${_getEstablishmentType(establishment.type)}',
            style: TextStyle(color: Colors.black54),
          ),
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

  String _getPriceLevel(_priceLevel) {
    var multiply;
    switch (_priceLevel) {
      case EstablishmentPriceLevel.Free:
        return 'Free';
      case EstablishmentPriceLevel.Inexpensive:
        multiply = 1;
        break;
      case EstablishmentPriceLevel.Moderate:
        multiply = 2;
        break;
      case EstablishmentPriceLevel.Expensive:
        multiply = 3;
        break;
      case EstablishmentPriceLevel.VeryExpensive:
        multiply = 4;
        break;
      default:
        return '';
    }
    return '${'€' * multiply} • ';
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
