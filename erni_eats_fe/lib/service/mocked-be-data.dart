Future getRestaurants() async {
  List<Restaurant> restaurants = [
    Restaurant('Derby pub', RestaurantEstimation(3, 12), 2, 'Pub', 'derby.png', false),
    Restaurant('Clock block', RestaurantEstimation(5, 54), 3, 'Pub', 'clockblock.png', true),
    Restaurant('Veg life', RestaurantEstimation(4, 8), 2, 'Pub', 'veglife.png', true),
    Restaurant('Alfa', RestaurantEstimation(1, 325), 1, 'Pub', 'alfa.png', true),
    Restaurant('Classic restaurant & Pub', RestaurantEstimation(3, 4), 2, 'Pub', 'alfa.png', false),
  ];
  return await Future.value(restaurants).timeout(const Duration(seconds: 1));
}

class Restaurant {
  String title;
  RestaurantEstimation estimation;
  int priceCategory;
  String type;
  String imgUrl;
  bool displayed;

  Restaurant(this.title, this.estimation, this.priceCategory, this.type, this.imgUrl, this.displayed);
}

class RestaurantEstimation {
  int value;
  int votes;

  RestaurantEstimation(this.value, this.votes);
}
