Future getRestaurants() async {
  List<Restaurant> restaurants = [
    Restaurant('Derby pub', RestaurantEstimation(3, 12), 2, 'Pub', 'assets/derby.png'),
    Restaurant('Clock block', RestaurantEstimation(5, 54), 3, 'Pub', 'assets/clockblock.png'),
    Restaurant('Veg life', RestaurantEstimation(4, 8), 2, 'Pub', 'assets/veglife.png'),
    Restaurant('Alfa', RestaurantEstimation(1, 325), 1, 'Pub', 'assets/alfa.png'),
    Restaurant('Classic restaurant & Pub', RestaurantEstimation(3, 4), 2, 'Pub', 'assets/alfa.png'),
  ];
  return await Future.value(restaurants).timeout(const Duration(seconds: 1));
}

class Restaurant {
  String title;
  RestaurantEstimation estimation;
  int priceCategory;
  String type;
  String imgUrl;

  Restaurant(this.title, this.estimation, this.priceCategory, this.type, this.imgUrl);
}

class RestaurantEstimation {
  int value;
  int votes;

  RestaurantEstimation(this.value, this.votes);
}
