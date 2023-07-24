import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/register_fase6_bloc.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/section_one_view.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/section_two_view.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/routes.dart';
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
              pageTitle: AppLocalizations.of(context)!.verifyemailandphone,
              nextPageTitle: "Setup Password",
              enableNextButton: snapshot,
              nextPressed: () async {
                final navigator = Navigator.of(context);
                // await bloc.box.put(TempFieldToRegistrtConstant.ratePerHour, bloc.ratePerHourController.text);
                await bloc.box.put(DatabaseFieldConstant.registrationStep, "6");
                navigator.pushNamed(RoutesConstants.registerfaze7Screen);
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
                        SectionOneView(
                          emailController: bloc.emailController,
                          emailOTPController: bloc.emailOTPController,
                          emailFieldShowingStatusValidated: bloc.emailFieldShowingStatusValidated,
                          onEmailchange: () => bloc.validateFieldsForFaze6(),
                          onPinChange: (p0) {
                            bloc.pinCode1 = p0;
                            bloc.validateFieldsForFaze6();
                          },
                        ),
                        SectionTwoView(
                            initialCountry: bloc.returnSelectedCountryFromDatabase(),
                            countryList: bloc.countriesList,
                            countryCodeCallBack: (value) {
                              bloc.countryCode = value;
                              bloc.validateFieldsForFaze6();
                            },
                            mobileNumberCallBack: (value) {
                              bloc.mobileNumber = value;
                              bloc.validateFieldsForFaze6();
                            },
                            phoneNumberOTPController: bloc.phoneNumberOTPController,
                            mobileFieldShowingStatusValidated: bloc.mobileFieldShowingStatusValidated,
                            onPinChange: (p0) {
                              bloc.pinCode2 = p0;
                              bloc.validateFieldsForFaze6();
                            }),
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
