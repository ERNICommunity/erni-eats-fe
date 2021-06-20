import 'package:erni_eats_fe/models/models.dart';
import 'package:erni_eats_fe/service/mocked-be-data.dart';
import 'package:flutter/material.dart';

Widget homeBody() {
  return FutureBuilder(
    future: getRestaurantsData(),
    initialData: [],
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data.length > 0) {
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Restaurant restaurant = snapshot.data[index];
              if (!restaurant.displayed) {
                return Column();
              }
              return Card(
                child: ListTile(
                  trailing: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(restaurant.imgUrl),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  title: Text(restaurant.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                              children:
                                  _starsForRating(restaurant.estimation.value)),
                          Text('(${restaurant.estimation.votes})'),
                        ],
                      ),
                      Text(
                          '${'€' * restaurant.priceCategory} • ${restaurant.type}'),
                    ],
                  ),
                ),
              );
            });
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
