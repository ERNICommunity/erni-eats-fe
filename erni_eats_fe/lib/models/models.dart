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
}

class EstablishmentType {
  static const Restaurant = "RESTAURANT";
  static const Pub = "PUB";
}

class EstablishmentPriceLevel {
  static const Moderate = "MODERATE";
  static const Inexpensive = "INEXPENSIVE";
}
