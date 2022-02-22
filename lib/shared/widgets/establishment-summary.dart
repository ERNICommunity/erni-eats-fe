import 'dart:typed_data';

import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/shared/widgets/stars-estimation.dart';
import 'package:erni_eats_fe/service/http-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              ? Text('${establishment.description}')
              : Column(),
          StarsEstimation(establishment.rating, establishment.userRatingsTotal),
          Text(
            '${_getPriceLevel(establishment.priceLevel)}${_getEstablishmentType(context, establishment.type)}',
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
            height: 50,
            width: 50,
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

  String _getEstablishmentType(BuildContext context, _type) {
    if (_type == EstablishmentType.Restaurant) {
      return AppLocalizations.of(context)!.establishment_Restaurant_Type;
    }
    if (_type == EstablishmentType.Pub) {
      return AppLocalizations.of(context)!.establishment_Pub_Type;
    }
    return '';
  }
}
