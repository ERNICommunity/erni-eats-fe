const String APP_TITLE = 'Eat11';

class SharedPreferencesKey {
  static const DisplayedEstablishments = 'displayed_establishments';
}

class HomePagePassedParameters {
  List<String> displayedEstablishments;

  HomePagePassedParameters(this.displayedEstablishments);
}

class EstablishmentPagePassedParameters {
  Establishment establishment;

  EstablishmentPagePassedParameters(this.establishment);
}

class Establishment {
  final String id;
  final String restaurantId;
  final String name;
  final String? alias;
  final String? description;
  final String type;
  final String websiteUrl;
  final String dailyMenuUrl;
  final num rating;
  final int userRatingsTotal;
  final String priceLevel;

  Establishment(
      {required this.id,
      required this.restaurantId,
      required this.name,
      this.alias,
      this.description,
      required this.type,
      required this.websiteUrl,
      required this.dailyMenuUrl,
      required this.rating,
      required this.userRatingsTotal,
      required this.priceLevel});

  factory Establishment.fromJson(Map json) {
    return Establishment(
      id: json['id'],
      restaurantId: json['restaurantId'],
      name: json['name'],
      alias: json['alias'],
      description: json['description'],
      type: json['type'],
      websiteUrl: json['websiteUrl'],
      dailyMenuUrl: json['dailyMenuUrl'],
      rating: json['rating'],
      userRatingsTotal: json['userRatingsTotal'],
      priceLevel: json['priceLevel'],
    );
  }

  @override
  String toString() {
    return 'Establishment{id: $id, restaurantId: $restaurantId, name: $name, alias: $alias, description: $description, type: $type, websiteUrl: $websiteUrl, dailyMenuUrl: $dailyMenuUrl, rating: $rating, userRatingsTotal: $userRatingsTotal, priceLevel: $priceLevel}';
  }
}

class EstablishmentType {
  static const Restaurant = "RESTAURANT";
  static const Pub = "PUB";
}

class EstablishmentPriceLevel {
  static const Moderate = "MODERATE";
  static const Inexpensive = "INEXPENSIVE";
}

class DailyMenu {
  String name;
  num? price;
  String type;

  DailyMenu({
    required this.name,
    this.price,
    required this.type,
  });

  factory DailyMenu.fromJson(Map json) {
    return DailyMenu(
      name: json['name'],
      price: json['price'],
      type: json['type'],
    );
  }

  @override
  String toString() {
    return 'DailyMenu{name: $name, price: $price, type: $type}';
  }
}

class DailyMenuItemType {
  static const Soup = 'SOUP';
  static const MainDish = 'MAIN_DISH';
}

class Iban {
  final String name;
  final String iban;

  Iban({
    required this.name,
    required this.iban,
  });
}

class Review {
  final String? authorName;
  final num rating;
  final String? imageUrl;
  final String reviewText;

  Review({
    this.authorName,
    required this.rating,
    this.imageUrl,
    required this.reviewText,
  });
}

class ContactInfo {
  final String address;
  final String openHours;

  ContactInfo({
    required this.address,
    required this.openHours,
  });
}
