import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/email_header.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/pin_field.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionOneView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController emailOTPController;
  final Function onEmailchange;
  final Function(OTPSTATUS) onPinChange;

  final ValueNotifier<bool> emailFieldShowingStatusValidated;
  const SectionOneView({
    super.key,
    required this.onEmailchange,
    required this.onPinChange,
    required this.emailController,
    required this.emailOTPController,
    required this.emailFieldShowingStatusValidated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EmailHeader(),
        CustomTextField(
          controller: emailController,
          hintText: AppLocalizations.of(context)!.emailaddress,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            LengthLimitingTextInputFormatter(35),
          ],
          onChange: (text) {
            emailOTPController.text = "";

            onEmailchange();
          },
        ),
        ValueListenableBuilder<bool>(
            valueListenable: emailFieldShowingStatusValidated,
            builder: (context, snapshot, child) {
              return snapshot
                  ? Column(
                      children: [
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: CustomText(
                            title: "Please Enter OTP You recive on the email",
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
                          pinController: emailOTPController,
                          callBack: (p0) {
                            onPinChange(p0);
                          },
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          color: const Color(0xffE8E8E8),
                        ),
                      ],
                    )
                  : Container();
            }),
      ],
    );
  }
}
