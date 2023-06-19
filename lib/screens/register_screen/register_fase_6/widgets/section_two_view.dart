import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/mobile_number_header.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/mobile_number_widget.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/pin_field.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionTwoView extends StatelessWidget {
  final Country initialCountry;
  final List<Country> countryList;
  final Function(String) countryCodeCallBack;
  final Function(String) mobileNumberCallBack;
  final ValueNotifier<bool> mobileFieldShowingStatusValidated;
  final TextEditingController phoneNumberOTPController;

  const SectionTwoView({
    super.key,
    required this.initialCountry,
    required this.countryList,
    required this.countryCodeCallBack,
    required this.mobileNumberCallBack,
    required this.mobileFieldShowingStatusValidated,
    required this.phoneNumberOTPController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MobileNumberHeader(),
        MobileNumberField(
          initialCountry: initialCountry,
          countryList: countryList,
          selectedCountryCode: (selectedCode) {
            countryCodeCallBack(selectedCode);
          },
          enteredPhoneNumber: (mobileNumber) {
            mobileNumberCallBack(mobileNumber);
          },
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
            valueListenable: mobileFieldShowingStatusValidated,
            builder: (context, snapshot, child) {
              return snapshot
                  ? Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
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
                          pinController: phoneNumberOTPController,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          color: const Color(0xffE8E8E8),
                        ),
                      ],
                    )
                  : Container();
            })
      ],
    );
  }
}
