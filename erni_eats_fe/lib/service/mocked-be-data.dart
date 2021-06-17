Future getRestaurants() async {
  List<Restaurant> restaurants = [
    Restaurant('Derby pub 1', RestaurantEstimation(3.5, 12), 1, 'Pub', 'assets/alfa.png'),
    Restaurant('Derby pub 2', RestaurantEstimation(3.5, 12), 1, 'Pub', 'assets/alfa.png'),
    Restaurant('Derby pub 3', RestaurantEstimation(3.5, 12), 1, 'Pub', 'assets/alfa.png'),
    Restaurant('Derby pub 4', RestaurantEstimation(3.5, 12), 1, 'Pub', 'assets/alfa.png'),
  ];
  return await Future.value(restaurants).timeout(const Duration(seconds: 1));
}

class Restaurant {
  String title;
  RestaurantEstimation estimation;
  num priceCategory;
  String type;
  String imgUrl;

  Restaurant(this.title, this.estimation, this.priceCategory, this.type, this.imgUrl);
}

class RestaurantEstimation {
  num value;
  num votes;

  RestaurantEstimation(this.value, this.votes);
}
