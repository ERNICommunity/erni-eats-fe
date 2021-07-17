import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/service/http-service.dart';

Future<Map<String, List<DailyMenu>>> getDailyMenuRepresentationMap(
    String establishmentId, String date) async {
  try {
    Map<String, List<DailyMenu>> representation = {
      DailyMenuItemType.Soup: [],
      DailyMenuItemType.MainDish: [],
    };
    List<DailyMenu> dailyMenu =
        await getDailyMenuByEstablishmentByDate(establishmentId, date);
    dailyMenu.forEach(
      (element) {
        if (element.type == DailyMenuItemType.Soup) {
          representation[DailyMenuItemType.Soup]!.add(element);
        }
        if (element.type == DailyMenuItemType.MainDish) {
          representation[DailyMenuItemType.MainDish]!.add(element);
        }
      },
    );
    return representation;
  } on Exception {
    throw Exception;
    // todo custom exceptions
  }
}

Future<List<String>> getEstablishmentIds() async {
  try {
    List<Establishment> establishments = await getAllEstablishments();
    return List<String>.from(
        establishments.map((establishment) => establishment.id));
  } on Exception catch (e) {
    throw Exception(e);
  }
}
