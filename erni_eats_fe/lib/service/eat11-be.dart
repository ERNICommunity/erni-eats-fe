import 'dart:convert';

import 'package:erni_eats_fe/models/models.dart';
import 'package:http/http.dart' as http;

String baseUrl = 'http://localhost:8080/api/v1/establishments';

// GET localhost:8080/api/v1/establishments
// vrati zoznam configuracii vsetkych restauracii o ktorych BE vie
Future<List<Establishment>> getRestaurants() async {
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    return List<Establishment>.from(
        jsonResponse.map((model) => Establishment.fromJson(model)));
  } else {
    throw Exception('Failed to load restaurants');
  }
}

// GET localhost:8080/api/v1/establishments/clock-block/daily-menu?date=2021-01-05
// vrati zoznam poloziek menu pre konkretny den
Future<List<DailyMenu>> getDailyMenu(String establishmentId) async {
  DateTime today = new DateTime.now();
  String queryDate = '${today.year.toString()}'
      '-${today.month.toString().padLeft(2, '0')}'
      '-${today.day.toString().padLeft(2, '0')}';

  String query = '$baseUrl/$establishmentId/daily-menu?$queryDate';
  final response = await http.get(Uri.parse(query));

  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    List<DailyMenu> dailyMenu = List<DailyMenu>.from(
        jsonResponse.map((model) => DailyMenu.fromJson(model)));
    return dailyMenu;
  } else {
    throw Exception('Failed to load daily menu for query: $query');
  }
}

// GET localhost:8080/api/v1/establishments/clock-block/daily-menu
// vrati zoznam poloziek menu pre TODAY
// todo use

// GET localhost:8080/api/v1/establishments/clock-block
// vrati configuraciu (nazov, rating a dalsie info) danej restiky
// todo use
