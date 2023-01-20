import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/points_in_last_view.dart';

class NoCallView extends StatelessWidget {
  final String language;
  const NoCallView({required this.language, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lottie/86231-confused.zip', height: 250),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomText(
            title: AppLocalizations.of(context)!.nocalltoday,
            fontSize: 20,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomText(
            title: AppLocalizations.of(context)!.checkcallfromcalender,
            fontSize: 14,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        hintToEncreaseMeetings(context),
      ],
    );
  }

  Widget hintToEncreaseMeetings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffE8E8E8),
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              CustomText(
                title: AppLocalizations.of(context)!.encreasemeetingshint,
                fontSize: 12,
                maxLins: 2,
                textAlign: TextAlign.center,
                textColor: const Color(0xff554d56),
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                title: AppLocalizations.of(context)!.encreasemeetingshintdesc,
                fontSize: 12,
                textColor: const Color(0xff554d56),
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "1",
                text: AppLocalizations.of(context)!.encreasemeetingstep1,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "2",
                text: AppLocalizations.of(context)!.encreasemeetingstep2,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "3",
                text: AppLocalizations.of(context)!.encreasemeetingstep3,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "4",
                text: AppLocalizations.of(context)!.encreasemeetingstep4,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "5",
                text: AppLocalizations.of(context)!.encreasemeetingstep5,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "6",
                text: AppLocalizations.of(context)!.encreasemeetingstep6,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "7",
                text: AppLocalizations.of(context)!.encreasemeetingstep7,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
