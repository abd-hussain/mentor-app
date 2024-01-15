import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mentor_app/models/https/rating_and_review_response.dart';
import 'package:mentor_app/screens/rating_and_review/rating_and_review_bloc.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:mentor_app/utils/constants/constant.dart';

class RatingAndReviewScreen extends StatefulWidget {
  const RatingAndReviewScreen({super.key});

  @override
  State<RatingAndReviewScreen> createState() => _RatingAndReviewScreenState();
}

class _RatingAndReviewScreenState extends State<RatingAndReviewScreen> {
  final bloc = RatingAndReviewBloc();

  @override
  void didChangeDependencies() {
    bloc.getRatingAndReviews();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF3F4F5),
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(
          title: AppLocalizations.of(context)!.ratingandreview,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
          child: ValueListenableBuilder<List<RatingAndReviewResponseData>>(
            valueListenable: bloc.ratingAndReviewsListNotifier,
            builder: (context, snapshot, child) {
              return ListView.builder(
                  itemCount: snapshot.length,
                  itemBuilder: (ctx, index) {
                    var noteDate = DateTime.parse(snapshot[index].createdAt!);
                    final String formattedDate =
                        bloc.formatter.format(noteDate);
                    TextEditingController controller = TextEditingController();

                    controller.text = snapshot[index].mentorResponse ?? "";

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                const Color(0xff034061),
                                            radius: 20,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: snapshot[index]
                                                          .profileImg !=
                                                      ""
                                                  ? FadeInImage(
                                                      placeholder: const AssetImage(
                                                          "assets/images/avatar.jpeg"),
                                                      image: NetworkImage(
                                                          AppConstant
                                                                  .imagesBaseURLForClient +
                                                              snapshot[index]
                                                                  .profileImg!,
                                                          scale: 1),
                                                    )
                                                  : Image.asset(
                                                      'assets/images/avatar.jpeg',
                                                      width: 110.0,
                                                      height: 110.0,
                                                      fit: BoxFit.fill,
                                                    ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 8,
                                            bottom: 0,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 10,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: snapshot[index]
                                                            .flagImage !=
                                                        ""
                                                    ? FadeInImage(
                                                        placeholder:
                                                            const AssetImage(
                                                                "assets/images/avatar.jpeg"),
                                                        image: NetworkImage(
                                                            AppConstant
                                                                    .imagesBaseURLForCountries +
                                                                snapshot[index]
                                                                    .flagImage!,
                                                            scale: 1),
                                                      )
                                                    : Image.asset(
                                                        'assets/images/avatar.jpeg',
                                                        width: 110.0,
                                                        height: 110.0,
                                                        fit: BoxFit.fill,
                                                      ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 4),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            title:
                                                "${snapshot[index].firstName} ${snapshot[index].lastName}",
                                            textColor: const Color(0xff444444),
                                            fontSize: 14,
                                            maxLins: 2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: CustomText(
                                              title: formattedDate,
                                              textColor:
                                                  const Color(0xff444444),
                                              fontSize: 10,
                                              maxLins: 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: RatingBarIndicator(
                                      rating: snapshot[index].stars!,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 30,
                                    ),
                                  ),
                                  CustomText(
                                    title: snapshot[index].comment ?? "",
                                    textColor: const Color(0xff444444),
                                    textAlign: TextAlign.start,
                                    fontSize: 14,
                                    maxLins: 4,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomTextField(
                                      onEditingComplete: () async {
                                        FocusScope.of(context).unfocus();
                                        await bloc
                                            .respondOnReview(
                                                id: snapshot[index].id!,
                                                responseMessage:
                                                    controller.text)
                                            .then((value) {
                                          bloc.getRatingAndReviews();
                                        });
                                      },
                                      controller: controller,
                                      hintText: AppLocalizations.of(context)!
                                          .mentorrespond,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ));
  }
}
