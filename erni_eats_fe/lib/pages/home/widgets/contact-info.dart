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
                      _getAddressWidget(contactInfo.address),
                      Padding(padding: EdgeInsets.only(bottom: 8)),
                      _getOpenHoursWidget(contactInfo.openHours),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Text('Nemáme informácie o adrese a otváracích hodinách.');
      },
    );
  }
}

Widget _getAddressWidget(String address) {
  if (address == '') {
    return Text('Nemáme informácie o adrese.');
  }
  return Row(
    children: [
      Icon(Icons.location_on),
      Padding(padding: EdgeInsets.only(right: 16)),
      Text(address),
    ],
  );
}

Widget _getOpenHoursWidget(List<OpenHours> openHours) {
  if (openHours.isEmpty) {
    return Text('Nemáme informácie o otváracích hodinách.');
  }
  return Column(
    children: [
      Row(
        children: [
          Icon(Icons.access_time),
          Padding(padding: EdgeInsets.only(right: 16)),
          Text('Otvorené:'),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(left: 42),
        child: ListView.builder(
          itemCount: openHours.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Text(openHours[index].day),
                Padding(padding: EdgeInsets.only(right: 8)),
                Text(openHours[index].openHours),
              ],
            );
          },
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        ),
      ),
    ],
  );
}
