import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/models/https/suffix_model.dart';
import 'package:mentor_app/models/working_hours.dart';
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
import 'package:mentor_app/shared_widget/loading_view.dart';
import 'package:mentor_app/shared_widget/speaking_language_field.dart';
import 'package:mentor_app/shared_widget/suffix_field.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
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
    bloc.getProfileInformations(context);
    bloc.getListOfCountries(context);
    bloc.getlistOfSuffix();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F5),
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(title: AppLocalizations.of(context)!.editprofileinformations),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<bool>(
            valueListenable: bloc.enableSaveButtonNotifier,
            builder: (context, snapshot, child) {
              return CustomButton(
                  enableButton: snapshot,
                  onTap: () {
                    //TODO
                    Navigator.of(context).pop();
                  });
            }),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatusNotifier,
            builder: (context, snapshot, child) {
              return snapshot == LoadingStatus.inprogress
                  ? const LoadingView()
                  : GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
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
                                            ValueListenableBuilder<List<SuffixData>>(
                                                valueListenable: bloc.listOfSuffix,
                                                builder: (context, snapshot, child) {
                                                  return SuffixField(
                                                    controller: bloc.suffixNameController,
                                                    listOfSuffix: bloc.listOfSuffix.value,
                                                    selectedSuffix: (p0) {
                                                      bloc.validateFields();
                                                    },
                                                  );
                                                }),
                                            const SizedBox(height: 10),
                                            CustomTextField(
                                              controller: bloc.firstNameController,
                                              hintText: AppLocalizations.of(context)!.firstnameprofile,
                                              keyboardType: TextInputType.name,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(45),
                                              ],
                                              onChange: (text) {
                                                bloc.validateFields();
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            CustomTextField(
                                              controller: bloc.lastNameController,
                                              hintText: AppLocalizations.of(context)!.lastnameprofile,
                                              keyboardType: TextInputType.name,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(45),
                                              ],
                                              onChange: (text) {
                                                bloc.validateFields();
                                              },
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
                                      CustomAttachTextField(
                                          isFromNetwork: bloc.iDImageUrl != "",
                                          urlImage: bloc.iDImageUrl == "" ? null : bloc.iDImageUrl,
                                          onAddImage: (file) {
                                            bloc.iDImage = file;
                                            bloc.validateFields();
                                          },
                                          onDeleteImage: () {
                                            bloc.iDImage = null;
                                            bloc.iDImageUrl = "";
                                            bloc.validateFields();
                                          }),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            ValueListenableBuilder<List<Country>>(
                                                valueListenable: bloc.listOfCountriesNotifier,
                                                builder: (context, snapshot, child) {
                                                  return CountryField(
                                                    controller: bloc.countryController,
                                                    listOfCountries: snapshot,
                                                    selectedCountry: (p0) {
                                                      bloc.selectedCountry = p0;
                                                      bloc.validateFields();
                                                    },
                                                  );
                                                }),
                                            const SizedBox(height: 10),
                                            GenderField(
                                              controller: bloc.genderController,
                                              onChange: (p0) => bloc.validateFields(),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    title: AppLocalizations.of(context)!.speakinglanguage,
                                                    fontSize: 12,
                                                    textColor: const Color(0xff444444),
                                                  ),
                                                  StreamBuilder<List<CheckBox>>(
                                                      stream: bloc.listOfSpeakingLanguageNotifier.stream,
                                                      builder: (context, snapshot) {
                                                        return snapshot.hasData
                                                            ? SpeakingLanguageField(
                                                                listOfLanguages: snapshot.data!,
                                                                selectedLanguage: (language) {
                                                                  bloc.listOfSpeakingLanguageNotifier.add(language);
                                                                  bloc.validateFields();
                                                                },
                                                              )
                                                            : const LoadingView();
                                                      }),
                                                ],
                                              ),
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
                                    bloc.validateFields();
                                  },
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  color: const Color(0xffE8E8E8),
                                  height: 1,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  controller: bloc.emailController,
                                  hintText: AppLocalizations.of(context)!.emailaddress,
                                  keyboardType: TextInputType.emailAddress,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(35),
                                  ],
                                  onChange: (text) => bloc.validateFields(),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: bloc.mobileNumberController,
                                  hintText: AppLocalizations.of(context)!.mobilenumber,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(35),
                                  ],
                                  onChange: (text) => bloc.validateFields(),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  color: const Color(0xffE8E8E8),
                                  height: 1,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  controller: bloc.referalCodeController,
                                  hintText: AppLocalizations.of(context)!.referalcodeprofile,
                                  readOnly: true,
                                  enabled: false,
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
                    );
            }),
      ),
    );
  }
}
