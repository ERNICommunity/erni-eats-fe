import 'package:flutter/material.dart';

class StarsEstimation extends StatelessWidget {
  final num rating;
  final int? userRatingsTotal;

  StarsEstimation(this.rating, this.userRatingsTotal);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Row(children: _starsForRating(rating)),
          if (userRatingsTotal != null)
            Text(
              '($userRatingsTotal)',
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
        ],
      ),
    );
  }

  List<Icon> _starsForRating(_rating) {
    num roundedToHalfRating =
        double.parse((_rating * 2).toStringAsFixed(0)) / 2;
    bool ratingWithHalf = roundedToHalfRating * 10 % 10 == 5;

    List<Icon> stars = [];
    for (int i = 0; i < 5; i++) {
      bool halfStarIteration = i + 1 == _rating.round() % 10;
      if (ratingWithHalf && halfStarIteration) {
        stars.add(Icon(
          Icons.star_half,
          size: 15.0,
        ));
      } else if (i < roundedToHalfRating) {
        stars.add(Icon(
          Icons.star,
          size: 15.0,
        ));
      } else {
        stars.add(Icon(
          Icons.star_border,
          size: 15.0,
        ));
      }
    }
    return stars;
  }
}
