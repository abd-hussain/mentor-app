import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mentor_app/screens/register_screen/register_bloc.dart';
import 'package:mentor_app/shared_widget/country_field.dart';
import 'package:mentor_app/shared_widget/custom_attach_textfield.dart';
import 'package:mentor_app/shared_widget/date_of_birth_field.dart';
import 'package:mentor_app/shared_widget/gender_field.dart';
import 'package:mentor_app/shared_widget/image_holder_field.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:mentor_app/shared_widget/suffix_field.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/utils/routes.dart';

class RegisterFaze2Screen extends StatefulWidget {
  const RegisterFaze2Screen({super.key});

  @override
  State<RegisterFaze2Screen> createState() => _RegisterFaze2ScreenState();
}

class _RegisterFaze2ScreenState extends State<RegisterFaze2Screen> {
  final bloc = RegisterBloc();

  @override
  void didChangeDependencies() {
    bloc.getlistOfSuffix();
    bloc.getlistOfCountries();
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
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze2();
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
                            bloc.validateFieldsForFaze2();
                          },
                          onDeleteImage: () {
                            bloc.profileImage = null;
                            bloc.profileImageUrl = "";
                            bloc.validateFieldsForFaze2();
                          }),
                      Expanded(
                        child: Column(
                          children: [
                            ValueListenableBuilder<Object>(
                                valueListenable: bloc.listOfSuffix,
                                builder: (context, snapshot, child) {
                                  return SuffixField(
                                    controller: bloc.suffixNameController,
                                    listOfSuffix: bloc.listOfSuffix.value,
                                    selectedSuffix: (p0) {
                                      bloc.selectedSuffix = p0;
                                      bloc.validateFieldsForFaze2();
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
                              onChange: (text) => bloc.validateFieldsForFaze2(),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: bloc.lastNameController,
                              hintText: AppLocalizations.of(context)!.lastnameprofile,
                              keyboardType: TextInputType.name,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(45),
                              ],
                              onChange: (text) => bloc.validateFieldsForFaze2(),
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
                            bloc.validateFieldsForFaze2();
                          },
                          onDeleteImage: () {
                            bloc.iDImage = null;
                            bloc.iDImageUrl = "";
                            bloc.validateFieldsForFaze2();
                          }),
                      Expanded(
                        child: Column(
                          children: [
                            ValueListenableBuilder<Object>(
                                valueListenable: bloc.listOfCountries,
                                builder: (context, snapshot, child) {
                                  return CountryField(
                                    controller: bloc.countryController,
                                    listOfCountries: bloc.listOfCountries.value,
                                    selectedCountry: (p0) {
                                      bloc.selectedCountry = p0;
                                      bloc.validateFieldsForFaze2();
                                    },
                                  );
                                }),
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
                  },
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
                    title: AppLocalizations.of(context)!.optional,
                    textAlign: TextAlign.start,
                    fontSize: 14,
                    textColor: const Color(0xff384048),
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: bloc.referalCodeController,
                  hintText: AppLocalizations.of(context)!.referalcodeprofile,
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(6)],
                  onChange: (text) => bloc.validateFieldsForFaze2(),
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<bool>(
                    valueListenable: bloc.enableNextBtn,
                    builder: (context, snapshot, child) {
                      return CustomButton(
                          buttonTitle: AppLocalizations.of(context)!.next,
                          enableButton: snapshot,
                          onTap: () async {
                            await bloc.box.put(DatabaseFieldConstant.registrationStep, "2");
                            await bloc.box.put(TempFieldToRegistrtConstant.suffix, bloc.suffixNameController.text);
                            await bloc.box.put(TempFieldToRegistrtConstant.firstName, bloc.firstNameController.text);
                            await bloc.box.put(TempFieldToRegistrtConstant.lastName, bloc.lastNameController.text);
                            await bloc.box
                                .put(TempFieldToRegistrtConstant.country, bloc.selectedCountry!.id.toString());
                            await bloc.box.put(TempFieldToRegistrtConstant.gender, bloc.genderController.text);
                            await bloc.box.put(TempFieldToRegistrtConstant.profileImage, bloc.profileImage!);
                            await bloc.box.put(TempFieldToRegistrtConstant.idImage, bloc.iDImage);
                            await bloc.box.put(TempFieldToRegistrtConstant.dateOfBirth, bloc.selectedDate!);
                            await bloc.box
                                .put(TempFieldToRegistrtConstant.referalCode, bloc.referalCodeController.text);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushNamed(RoutesConstants.registerfaze3Screen);
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
