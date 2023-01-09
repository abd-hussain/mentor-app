import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

class TitleTableWidget extends StatelessWidget {
  const TitleTableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: CustomText(
          title: AppLocalizations.of(context)!.selectCountry,
          fontSize: 20,
          textColor: const Color(0xff034061),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
