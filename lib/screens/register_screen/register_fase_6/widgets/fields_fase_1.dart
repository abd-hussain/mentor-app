import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/register_fase6_bloc.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FieldsFase1 extends StatelessWidget {
  final Register6Bloc bloc;
  const FieldsFase1({super.key, required this.bloc});

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
        CustomTextField(
          controller: bloc.emailController,
          hintText: AppLocalizations.of(context)!.emailaddress,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            LengthLimitingTextInputFormatter(35),
          ],
          onChange: (text) {
            bloc.emailOTPController.text = "";
            bloc.validateFieldsForFaze6();
          },
        ),
      ],
    );
  }
}
