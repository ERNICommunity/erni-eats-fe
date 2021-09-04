import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/pages/home/widgets/stars-estimation.dart';
import 'package:flutter/material.dart';

class ReviewsWidget extends StatelessWidget {
  final Establishment establishment;

  // todo use data from BE
  final List<Review> dummyReviews = [
    Review(
      authorName: 'Jane Doe',
      imageUrl:
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTd8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80',
      rating: 5.0,
      reviewText: 'Awesome',
    ),
    Review(
      imageUrl:
          'https://pbs.twimg.com/profile_images/955633850264190976/y8A1kJ_g.jpg',
      rating: 1.5,
      reviewText: 'Nedalo sa',
    ),
    Review(
      authorName: 'John Doe',
      rating: 3.0,
      reviewText: 'Dalo sa',
    ),
  ];

  ReviewsWidget(this.establishment);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(dummyReviews.length, (index) {
        Review review = dummyReviews[index];
        return Card(
          child: Column(
            children: [
              if (review.imageUrl != null)
                _getReviewImageWidget(review.imageUrl!),
              StarsEstimation(review.rating, null),
              Text("\"${review.reviewText}\""),
              if (review.authorName != null)
                Text(review.authorName!)
              else
                Text('(Anonymously)'),
            ],
          ),
        );
      }),
    );
  }
}

Widget _getReviewImageWidget(String imageUrl) {
  return Container(
    height: 250,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fitHeight,
        image: NetworkImage(imageUrl),
      ),
      shape: BoxShape.rectangle,
    ),
  );
}
