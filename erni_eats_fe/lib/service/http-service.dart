import 'dart:convert';

import 'package:erni_eats_fe/data/data.dart';
import 'package:http/http.dart' as http;

String baseUrl = 'http://localhost:8080/api/v1/establishments';

// GET /
// vrati zoznam configuracii vsetkych podnikov o ktorych BE vie
Future<List<Establishment>> getAllEstablishments() async {
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    return List<Establishment>.from(
        jsonResponse.map((model) => Establishment.fromJson(model)));
  } else {
    throw Exception('Failed to load restaurants');
  }
}

// GET /{establishmentId}/daily-menu?date={date}
// vrati zoznam poloziek menu vybraneho podniku pre konkretny den
Future<List<DailyMenu>> getDailyMenuByEstablishmentByDate(
    String establishmentId, String date) async {
  String query = '$baseUrl/$establishmentId/daily-menu?$date';
  final response = await http.get(Uri.parse(query));

  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    List<DailyMenu> dailyMenu = List<DailyMenu>.from(
        jsonResponse.map((model) => DailyMenu.fromJson(model)));
    return dailyMenu;
  } else {
    throw Exception(
        'Failed to load establishment daily menu with query: $query');
  }
}

// GET /{establishmentId}/daily-menu
// vrati zoznam poloziek menu pre TODAY

// GET /{establishmentId}
// vrati configuraciu (nazov, rating a dalsie info) danej restiky

// GET /{establishmentId}/reviews
// vrati zoznam recenzii pre podnik
Future<List<Review>> getReviewsByEstablishmentId(String establishmentId) async {
  String query = '$baseUrl/$establishmentId/reviews';
  final response = await http.get(Uri.parse(query));

  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    List<Review> reviews =
        List<Review>.from(jsonResponse.map((model) => Review.fromJson(model)));
    return reviews;
  } else {
    throw Exception('Failed to load establishment reviews with query: $query');
  }
}
