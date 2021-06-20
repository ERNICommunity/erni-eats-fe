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
