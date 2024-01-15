import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_app/models/https/rating_and_review_response.dart';
import 'package:mentor_app/services/mentor_settings.dart';
import 'package:mentor_app/utils/mixins.dart';

class RatingAndReviewBloc extends Bloc<MentorSettingsService> {
  final ValueNotifier<List<RatingAndReviewResponseData>>
      ratingAndReviewsListNotifier =
      ValueNotifier<List<RatingAndReviewResponseData>>([]);

  final DateFormat formatter = DateFormat('yyyy/MM/dd hh:mm');

  void getRatingAndReviews() async {
    service.getMentorRatingAndReviews().then((value) {
      if (value.data != null) {}
      ratingAndReviewsListNotifier.value = value.data!;
    });
  }

  Future<void> respondOnReview(
      {required int id, required String responseMessage}) async {
    await service.respondOnReview(id: id, responseMessage: responseMessage);
  }

  @override
  onDispose() {
    ratingAndReviewsListNotifier.dispose();
  }
}
