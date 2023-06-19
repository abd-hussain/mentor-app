import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/register_fase6_bloc.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/email_header.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/mobile_number_header.dart';

import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/mobile_number_widget.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/pin_field.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterFaze6Screen extends StatefulWidget {
  const RegisterFaze6Screen({super.key});

  @override
  State<RegisterFaze6Screen> createState() => _RegisterFaze6ScreenState();
}

class _RegisterFaze6ScreenState extends State<RegisterFaze6Screen> {
  final bloc = Register6Bloc();

  @override
  void didChangeDependencies() {
    bloc.listOfCountries();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: ""),
      bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: bloc.enableNextBtn,
          builder: (context, snapshot, child) {
            return RegistrationFooterView(
              pageCount: 6,
              pageTitle: "Verify Email & Phone",
              nextPageTitle: "Setup Password",
              enableNextButton: snapshot,
              nextPressed: () async {
                // final navigator = Navigator.of(context);
                // await bloc.box.put(TempFieldToRegistrtConstant.ratePerHour, bloc.ratePerHourController.text);
                // await bloc.box.put(DatabaseFieldConstant.registrationStep, "6");
                // navigator.pushNamed(RoutesConstants.registerfaze7Screen);
              },
            );
          }),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze6();
        },
        child: SafeArea(
          child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: bloc.loadingStatus,
              builder: (context, loadingStatus, child) {
                if (loadingStatus == LoadingStatus.inprogress) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const EmailHeader(),
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
                        ValueListenableBuilder<bool>(
                            valueListenable: bloc.emailFieldShowingStatusValidated,
                            builder: (context, snapshot, child) {
                              return snapshot
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16, right: 16),
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
                                        PinField(pinController: bloc.emailOTPController),
                                        const SizedBox(height: 16),
                                        Container(
                                          height: 1,
                                          color: const Color(0xffE8E8E8),
                                        ),
                                      ],
                                    )
                                  : Container();
                            }),
                        const MobileNumberHeader(),
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
                        ValueListenableBuilder<bool>(
                            valueListenable: bloc.mobileFieldShowingStatusValidated,
                            builder: (context, snapshot, child) {
                              return snapshot
                                  ? Column(
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
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
