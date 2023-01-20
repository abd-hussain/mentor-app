import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/points_in_last_view.dart';

class RegisterInfoBottomSheetsUtil {
  final BuildContext context;

  RegisterInfoBottomSheetsUtil({
    required this.context,
  });

  Future bottomSheet({required Function() openNext}) async {
    return await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      enableDrag: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
          child: Wrap(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const Expanded(child: SizedBox()),
                  CustomText(
                    title: AppLocalizations.of(context)!.registernow,
                    textColor: const Color(0xff444444),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Center(
                child: CustomText(
                  title: "1 / 3",
                  textColor: const Color(0xff444444),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Lottie.asset(
                    'assets/lottie/132033-green-login.zip',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomText(
                title: "AppLocalizations.of(context)!.bookinglaststeptitle",
                textColor: const Color(0xff444444),
                fontSize: 14,
                maxLins: 3,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 20),
              PointsInLastViewBooking(
                number: "1",
                text: "AppLocalizations.of(context)!.bookinglaststeptext1",
              ),
              const SizedBox(height: 20),
              PointsInLastViewBooking(
                number: "2",
                text: "AppLocalizations.of(context)!.bookinglaststeptext2",
              ),
              const SizedBox(height: 20),
              PointsInLastViewBooking(
                number: "3",
                text: "AppLocalizations.of(context)!.bookinglaststeptext3",
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
