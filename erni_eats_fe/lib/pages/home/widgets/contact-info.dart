import 'package:erni_eats_fe/data/data.dart';
import 'package:flutter/material.dart';

class ContactInfoWidget extends StatelessWidget {

  final Establishment establishment;

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
                // todo address
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Padding(padding: EdgeInsets.only(right: 16)),
                    Text('Street name 12, 345 67 Petrzalka'),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 8)),
                // todo open hours
                Row(
                  children: [
                    Icon(Icons.access_time),
                    Padding(padding: EdgeInsets.only(right: 16)),
                    Text('Otvorené:'),
                    Text('12:34 - 56:78'),
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