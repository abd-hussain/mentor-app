import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationFooterView extends StatelessWidget {
  final int pageCount;
  final int maxpageCount;
  final String pageTitle;
  final String nextPageTitle;
  final Function() nextPressed;

  const RegistrationFooterView(
      {super.key,
      required this.pageCount,
      this.maxpageCount = 3,
      required this.pageTitle,
      required this.nextPageTitle,
      required this.nextPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: const Color(0xff1F1F1F),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CustomText(title: "$pageCount/$maxpageCount", fontSize: 22),
                const SizedBox(width: 8),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: pageTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(title: "${AppLocalizations.of(context)!.next}: $nextPageTitle", fontSize: 12)
                  ],
                )),
                CustomButton(
                  enableButton: true,
                  buttonTitle: AppLocalizations.of(context)!.next,
                  onTap: () => nextPressed(),
                )
              ],
            ),
          ),
          Container(height: 1, color: const Color(0xff444444)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(title: AppLocalizations.of(context)!.slogen, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
