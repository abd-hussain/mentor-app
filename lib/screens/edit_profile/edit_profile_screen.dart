import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/screens/edit_profile/edit_profile_bloc.dart';
import 'package:mentor_app/shared_widget/country_field.dart';
import 'package:mentor_app/shared_widget/custom_attach_textfield.dart';
import 'package:mentor_app/shared_widget/date_of_birth_field.dart';
import 'package:mentor_app/shared_widget/gender_field.dart';
import 'package:mentor_app/shared_widget/image_holder_field.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final bloc = EditProfileBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Edit Profile init Called ...');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF3F4F5),
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(title: AppLocalizations.of(context)!.editprofileinformations),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
              enableButton: bloc.enableSaveButton,
              onTap: () {
                //TODO
                Navigator.of(context).pop();
              }),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: const Offset(0, 0.1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 16),
                    Container(
                      color: const Color(0xffE8E8E8),
                      height: 1,
                    ),
                    const SizedBox(height: 16),
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
                                CountryField(
                                  controller: bloc.countryController,
                                  listOfCountries: bloc.listOfCountries,
                                  selectedCountry: (p0) {
                                    bloc.selectedCountry = p0;
                                  },
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: bloc.cityController,
                                  hintText: "City",
                                  keyboardType: TextInputType.name,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(45),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                GenderField(
                                  controller: bloc.genderController,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                      },
                    ),
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
                      inputFormatters: [LengthLimitingTextInputFormatter(6)],
                      onChange: (text) => {},
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
