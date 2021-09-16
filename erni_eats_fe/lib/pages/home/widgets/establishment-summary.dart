import 'dart:typed_data';

import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/home/widgets/stars-estimation.dart';
import 'package:erni_eats_fe/service/http-service.dart';
import 'package:flutter/material.dart';

class EstablishmentSummaryWidget extends StatelessWidget {
  final Establishment establishment;

  EstablishmentSummaryWidget(this.establishment);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // todo show image
      leading: _getLogoWidget(establishment),
      title: Text(establishment.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          establishment.description != null
              ? Text('${establishment.description}',
                  style: TextStyle(color: Colors.black))
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
    return FutureBuilder(
      future: getLogoByEstablishmentId(this.establishment.id),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: Colors.grey);
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          Uint8List logo = snapshot.data;
          Image logoImage = Image.memory(logo);
          return Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: logoImage.image,
              ),
              shape: BoxShape.circle,
            ),
          );
        }
        return Container(
          height: 80,
          width: 80,
          child: CircleAvatar(
            child: Icon(
              Icons.dining,
              size: 24.0,
              color: Colors.grey,
            ),
          ),
        );
      },
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
