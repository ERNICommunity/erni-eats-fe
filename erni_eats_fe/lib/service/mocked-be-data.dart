import 'package:erni_eats_fe/models/models.dart';

Future getRestaurantsData() async {
  List<Restaurant> restaurants = [
    Restaurant('Derby pub', RestaurantEstimation(3, 12), 2, 'Pub', 'derby.png', false),
    Restaurant('Clock block', RestaurantEstimation(5, 54), 3, 'Restaurant & Beer', 'clockblock.png', true),
    Restaurant('Veg life', RestaurantEstimation(4, 8), 2, 'Veggie', 'veglife.png', true),
    Restaurant('Alfa', RestaurantEstimation(1, 325), 1, 'Pub with food', 'alfa.png', true),
    Restaurant('Classic restaurant & Pub', RestaurantEstimation(3, 4), 2, 'Pub', 'alfa.png', false),
  ];
  return await Future.value(restaurants).timeout(const Duration(seconds: 1));
}
