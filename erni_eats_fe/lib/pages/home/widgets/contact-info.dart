import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/service/http-service.dart';
import 'package:flutter/material.dart';

class ContactInfoWidget extends StatelessWidget {
  final Establishment establishment;

  ContactInfoWidget(this.establishment);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getContactInfoByEstablishmentId(this.establishment.id),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // todo implement if-case for ConnectionState.waiting (show spinner)
            return Column();
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            ContactInfo contactInfo = snapshot.data;
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
                            Text(contactInfo.address),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 8)),
                        Row(
                          children: [
                            Icon(Icons.access_time),
                            Padding(padding: EdgeInsets.only(right: 16)),
                            Text('Otvorené:'),
                            if (contactInfo.openHours == null)
                              Text('---')
                            else
                              Text(contactInfo.openHours!),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Text('Nemáme informácie o otváracích hodinách.');
        });
  }
}
