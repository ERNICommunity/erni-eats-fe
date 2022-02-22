import 'package:erni_eats_fe/data/data.dart';
import 'package:erni_eats_fe/shared/widgets/stars-estimation.dart';
import 'package:erni_eats_fe/service/http-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewsWidget extends StatelessWidget {
  final Establishment establishment;

  ReviewsWidget(this.establishment);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getReviewsByEstablishmentId(this.establishment.id),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.grey),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data.length > 0 &&
            snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Review review = snapshot.data[index];
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
                      Text(
                          '(${AppLocalizations.of(context)!.reviewsSection_Anonymously_Text})'),
                  ],
                ),
              );
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data.length == 0) {
          return Text(AppLocalizations.of(context)!.reviewsSection_NoReviews);
        }
        return Text(
            AppLocalizations.of(context)!.reviewsSection_NoReviews_Error);
      },
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
