import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailHeader extends StatelessWidget {
  const EmailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: CustomText(
            title: "Please Enter Your Email Address",
            fontSize: 14,
            textColor: Color(0xff444444),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: CustomText(
            title: AppLocalizations.of(context)!.enteryouremailexample,
            fontSize: 10,
            textColor: Colors.grey,
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
