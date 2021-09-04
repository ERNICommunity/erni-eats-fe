import 'package:erni_eats_fe/data/data.dart';
import 'package:flutter/material.dart';

class ContactInfoWidget extends StatelessWidget {
  final Establishment establishment;

  // todo use data from BE
  final ContactInfo dummyContactInfo = ContactInfo(
    address: 'Street name 12, 345 67 Petrzalka',
    openHours: '12:34 - 56:78',
  );

  ContactInfoWidget(this.establishment);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // todo map
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Padding(padding: EdgeInsets.only(right: 16)),
                    Text(dummyContactInfo.address),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 8)),
                Row(
                  children: [
                    Icon(Icons.access_time),
                    Padding(padding: EdgeInsets.only(right: 16)),
                    Text('Otvorené:'),
                    Text(dummyContactInfo.openHours),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
