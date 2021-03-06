const String APP_TITLE = 'eat11';
const String APP_TITLE_SHORT = '11';

const String FeedbackEmail = 'eat.11.feedback@gmail.com';

class SharedPreferencesKey {
  static const DisplayedEstablishments = 'displayed_establishments';
  static const AppTheme = 'app_theme';
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
  final ContactInfo? contactInfo;

  Establishment({
    required this.id,
    required this.restaurantId,
    required this.name,
    this.alias,
    this.description,
    required this.type,
    required this.websiteUrl,
    required this.dailyMenuUrl,
    required this.rating,
    required this.userRatingsTotal,
    required this.priceLevel,
    this.contactInfo,
  });

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
      contactInfo: ContactInfo.fromJson(json['contactInfo']),
    );
  }

  @override
  String toString() {
    return 'Establishment{id: $id, restaurantId: $restaurantId, name: $name, alias: $alias, description: $description, type: $type, websiteUrl: $websiteUrl, dailyMenuUrl: $dailyMenuUrl, rating: $rating, userRatingsTotal: $userRatingsTotal, priceLevel: $priceLevel, contactInfo: $contactInfo}';
  }
}

class EstablishmentType {
  static const Restaurant = "RESTAURANT";
  static const Pub = "PUB";
  static const FoodCourt = "FOOD_COURT";
  static const FastFool = "FAST_FOOD";
}

class EstablishmentPriceLevel {
  static const Free = "FREE";
  static const Inexpensive = "INEXPENSIVE";
  static const Moderate = "MODERATE";
  static const Expensive = "EXPENSIVE";
  static const VeryExpensive = "VERY_EXPENSIVE";
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
  final String id;
  final String establishmentId;
  final String? authorName;
  final num rating;
  final String? imageUrl;
  final String reviewText;

  Review({
    required this.id,
    required this.establishmentId,
    this.authorName,
    required this.rating,
    this.imageUrl,
    required this.reviewText,
  });

  factory Review.fromJson(Map json) {
    return Review(
      id: json['id'],
      establishmentId: json['establishmentId'],
      authorName: json['authorName'],
      rating: json['rating'],
      imageUrl: json['imageUrl'],
      reviewText: json['reviewText'],
    );
  }
}

class ContactInfo {
  final String id;
  final String establishmentId;
  final String address;
  final List<OpenHours> openHours;
  final String coordinates;

  ContactInfo({
    required this.id,
    required this.establishmentId,
    required this.address,
    required this.openHours,
    required this.coordinates,
  });

  factory ContactInfo.fromJson(Map json) {
    return ContactInfo(
      id: json['id'],
      establishmentId: json['establishmentId'],
      address: json['address'],
      openHours: List<OpenHours>.from(json['openHours']
          .map((openHoursItem) => OpenHours.fromJson(openHoursItem))),
      coordinates: json['coordinates'],
    );
  }

  @override
  String toString() {
    return 'ContactInfo{establishmentId: $establishmentId, address: $address, openHours: $openHours, coordinates: $coordinates}';
  }
}

class OpenHours {
  final String day;
  final String openHours;

  OpenHours({
    required this.day,
    required this.openHours,
  });

  factory OpenHours.fromJson(Map json) {
    return OpenHours(day: json['day'], openHours: json['openHours']);
  }
}
