import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/register_fase6_bloc.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/pin_field.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FieldsFase4 extends StatelessWidget {
  final Register6Bloc bloc;

  const FieldsFase4({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: CustomText(
            title: "Please Enter OTP You recive on the Phone Number",
            fontSize: 14,
            textColor: Color(0xff444444),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: CustomText(
            title: AppLocalizations.of(context)!.enteryourotpnumberexample,
            fontSize: 11,
            textColor: Colors.grey,
          ),
        ),
        const SizedBox(height: 14),
        PinField(
          pinController: bloc.phoneNumberOTPController,
          bloc: bloc,
        ),
        const SizedBox(height: 16),
        Container(
          height: 1,
          color: const Color(0xffE8E8E8),
        ),
      ],
    );
  }
}
