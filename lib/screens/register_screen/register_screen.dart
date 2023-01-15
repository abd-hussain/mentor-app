import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:mentor_app/screens/register_screen/register_bloc.dart';
import 'package:mentor_app/shared_widget/country_field.dart';
import 'package:mentor_app/shared_widget/date_of_birth_field.dart';
import 'package:mentor_app/shared_widget/gender_field.dart';
import 'package:mentor_app/shared_widget/image_holder_field.dart';
import 'package:mentor_app/shared_widget/bottom_sheet_util.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final bloc = RegisterBloc();

class _RegisterScreenState extends State<RegisterScreen> {
  // TODO Compleate Registration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: ""),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFields();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: bloc.box.get(DatabaseFieldConstant.language) == "ar"
                      ? const EdgeInsets.only(right: 16)
                      : const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      ImageHolderField(
                          isFromNetwork: bloc.profileImageUrl != "",
                          urlImage: bloc.profileImageUrl == "" ? null : bloc.profileImageUrl,
                          onAddImage: (file) {
                            bloc.profileImage = file;
                            bloc.validateFields();
                          },
                          onDeleteImage: () {
                            bloc.profileImage = null;
                            bloc.profileImageUrl = "";
                            bloc.validateFields();
                          }),
                      Expanded(
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: bloc.suffixNameController,
                              hintText: AppLocalizations.of(context)!.suffixenameprofile,
                              keyboardType: TextInputType.name,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(45),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: bloc.firstNameController,
                              hintText: AppLocalizations.of(context)!.firstnameprofile,
                              keyboardType: TextInputType.name,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(45),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: bloc.lastNameController,
                              hintText: AppLocalizations.of(context)!.lastnameprofile,
                              keyboardType: TextInputType.name,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(45),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CountryField(
                      controller: bloc.countryController,
                      listOfCountries: bloc.listOfCountries,
                      selectedCountry: (p0) {
                        bloc.selectedCountry = p0;
                      },
                    ),
                    GenderField(controller: bloc.genderController),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: CustomText(
                    title: AppLocalizations.of(context)!.dbprofile,
                    textAlign: TextAlign.start,
                    fontSize: 14,
                    textColor: const Color(0xff384048),
                  ),
                ),
                const SizedBox(height: 10),
                DateOfBirthField(
                    selectedDate: bloc.selectedDate,
                    language: bloc.box.get(DatabaseFieldConstant.language),
                    dateSelected: (p0) {
                      bloc.selectedDate = p0;
                    }),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: bloc.emailController,
                  hintText: AppLocalizations.of(context)!.emailaddress,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(35),
                  ],
                  onChange: (text) => {},
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: bloc.mobileNumberController,
                  hintText: AppLocalizations.of(context)!.mobilenumber,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(35),
                  ],
                  onChange: (text) => {},
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: bloc.referalCodeController,
                  hintText: AppLocalizations.of(context)!.referalcodeprofile,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  onChange: (text) => {},
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<bool>(
                    valueListenable: bloc.enableNextBtn,
                    builder: (context, snapshot, child) {
                      return CustomButton(
                          buttonTitle: AppLocalizations.of(context)!.submit,
                          enableButton: snapshot,
                          onTap: () {
                            final navigator = Navigator.of(context);

                            // bloc.callRequest(context).then((value) async {
                            //   await bloc.box.put(DatabaseFieldConstant.isUserLoggedIn, true);
                            //   await bloc.box.put(DatabaseFieldConstant.userFirstName, bloc.firstNameController.text);
                            //   await bloc.box.put(DatabaseFieldConstant.userid, bloc.userId.toString());
                            //   if (bloc.selectedCountry != null) {
                            //     await bloc.box
                            //         .put(DatabaseFieldConstant.countryId, bloc.selectedCountry!.id.toString());
                            //     await bloc.box.put(DatabaseFieldConstant.countryFlag, bloc.selectedCountry!.flagImage);
                            //   }
                            //   bloc.loadingStatus.value = LoadingStatus.finish;

                            //   await navigator.pushNamedAndRemoveUntil(RoutesConstants.mainContainer, (route) => false);
                            // });
                          });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
