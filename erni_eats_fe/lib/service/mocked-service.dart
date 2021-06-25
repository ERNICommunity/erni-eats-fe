import 'package:erni_eats_fe/models/models.dart';
import 'package:erni_eats_fe/service/mocked-be-data.dart';

Future getRestaurants() async {
  List<Restaurant> restaurants = await getRestaurantsData();
  return restaurants;
}