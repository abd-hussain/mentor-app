import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/register_fase6_bloc.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/mobile_number_widget.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FieldsFase3 extends StatelessWidget {
  final Register6Bloc bloc;
  final FieldCanShow fieldShowingStatus;

  const FieldsFase3({super.key, required this.bloc, required this.fieldShowingStatus});

  @override
  Widget build(BuildContext context) {
    return fieldShowingStatus == FieldCanShow.phoneNumber || fieldShowingStatus == FieldCanShow.phoneNumberOTP
        ? Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: CustomText(
                  title: "Please Enter Your Phone Number",
                  fontSize: 14,
                  textColor: Color(0xff444444),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: CustomText(
                  title: AppLocalizations.of(context)!.enteryourphonenumberexample,
                  fontSize: 10,
                  textColor: Colors.grey,
                ),
              ),
              const SizedBox(height: 14),
              MobileNumberField(
                initialCountry: bloc.returnSelectedCountryFromDatabase(),
                countryList: bloc.countriesList,
                selectedCountryCode: (selectedCode) {
                  bloc.countryCode = selectedCode;
                },
                enteredPhoneNumber: (mobileNumber) {
                  bloc.mobileNumber = mobileNumber;
                },
              ),
              const SizedBox(height: 16),
            ],
          )
        : Container();
  }
}
