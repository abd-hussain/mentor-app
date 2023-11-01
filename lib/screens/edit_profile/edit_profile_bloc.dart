import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/models/https/suffix_model.dart';
import 'package:mentor_app/models/https/update_account_request.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/services/account_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/gender_format.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileBloc extends Bloc<AccountService> {
  ValueNotifier<LoadingStatus> loadingStatusNotifier =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  ValueNotifier<bool> enableSaveButtonNotifier = ValueNotifier<bool>(false);
  ValueNotifier<List<Country>> listOfCountriesNotifier =
      ValueNotifier<List<Country>>([]);
  ValueNotifier<List<CheckBox>> listOfSpeakingLanguageNotifier =
      ValueNotifier<List<CheckBox>>([]);
  List<String> listOfSpeakingLanguage = [];
  String? selectedDate;

  final box = Hive.box(DatabaseBoxConstant.userInfo);
  TextEditingController suffixNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  ValueNotifier<List<SuffixData>> listOfSuffix =
      ValueNotifier<List<SuffixData>>([]);

  String profileImageUrl = "";
  File? profileImage;

  String iDImageUrl = "";
  File? iDImage;

  Country? selectedCountry;

  validateFields() {
    enableSaveButtonNotifier.value = false;

    bool areAllFieldsValid = suffixNameController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        (profileImageUrl != "" || profileImage != null) &&
        (iDImageUrl != "" || iDImage != null) &&
        selectedCountry != null &&
        genderController.text != "" &&
        mobileNumberController.text.isNotEmpty &&
        bioController.text.isNotEmpty;

    bool hasValidLanguage =
        listOfSpeakingLanguageNotifier.value.any((item) => item.isEnable);

    if (areAllFieldsValid && hasValidLanguage) {
      enableSaveButtonNotifier.value = true;
    }
  }

  void getProfileInformations(BuildContext context) async {
    loadingStatusNotifier.value = LoadingStatus.inprogress;
    service.getProfileInfo().then((value) {
      final data = value.data;

      if (data != null) {
        suffixNameController.text = data.suffixeName ?? "";
        firstNameController.text = data.firstName ?? "";
        lastNameController.text = data.lastName ?? "";
        emailController.text = data.email ?? "";
        mobileNumberController.text = data.mobileNumber ?? "";
        referalCodeController.text = data.referalCode ?? "";
        bioController.text = data.bio ?? "";
        profileImageUrl = data.profileImg ?? "";

        iDImageUrl = data.idImg ?? "";

        selectedDate = data.dateOfBirth ?? "";

        if (data.dBCountries != null) {
          final dbCountries = data.dBCountries!;

          selectedCountry = Country(
            id: dbCountries.id ?? 0,
            flagImage: dbCountries.flagImage ?? "",
            name: box.get(DatabaseFieldConstant.language) == "en"
                ? dbCountries.nameEnglish ?? ""
                : dbCountries.nameArabic ?? "",
            currency: box.get(DatabaseFieldConstant.language) == "en"
                ? dbCountries.currencyEnglish ?? ""
                : dbCountries.currencyArabic ?? "",
            dialCode: dbCountries.dialCode ?? "",
          );

          countryController.text =
              box.get(DatabaseFieldConstant.language) == "en"
                  ? dbCountries.nameEnglish ?? ""
                  : dbCountries.nameArabic ?? "";
        }

        if (data.gender != null) {
          if (data.gender == 0) {
            genderController.text = AppLocalizations.of(context)!.gendermale;
          } else if (data.gender == 1) {
            genderController.text = AppLocalizations.of(context)!.genderfemale;
          } else {
            genderController.text = AppLocalizations.of(context)!.genderother;
          }
        }

        if (data.speakingLanguage != null) {
          listOfSpeakingLanguageNotifier.value =
              _prepareList(data.speakingLanguage!);
        }
      }

      getListOfCountries(context);
    });
  }

  void getListOfCountries(BuildContext context) {
    locator<FilterService>().countries().then((value) async {
      listOfCountriesNotifier.value = value.data!
        ..sort((a, b) => a.id!.compareTo(b.id!));
      loadingStatusNotifier.value = LoadingStatus.finish;
    });
  }

  void getlistOfSuffix() {
    locator<FilterService>().suffix().then((value) {
      listOfSuffix.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
    });
  }

  List<CheckBox> _prepareList(List<String> theList) {
    List<CheckBox> list = [];

    final languagesToCheck = [
      "English",
      "العربية",
      "Français",
      "Español",
      "Türkçe"
    ];
    for (var language in languagesToCheck) {
      final isEnable = theList.any((item) => item.contains(language));
      list.add(CheckBox(value: language, isEnable: isEnable));
    }
    return list;
  }

  Future updateProfileInfo(BuildContext context) async {
    final speackingLanguage = listOfSpeakingLanguageNotifier.value
        .where((item) => item.isEnable)
        .map((item) => item.value)
        .toList();

    UpdateAccountRequest account = UpdateAccountRequest(
      suffix: suffixNameController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      profileImage: profileImage,
      iDImage: iDImage,
      countryId: selectedCountry!.id!,
      dateOfBirth: selectedDate!,
      speackingLanguage: speackingLanguage,
      bio: bioController.text,
      gender:
          GenderFormat().convertStringToIndex(context, genderController.text),
    );
    return service.updateProfileInfo(account: account);
  }

  @override
  onDispose() {
    loadingStatusNotifier.dispose();
    enableSaveButtonNotifier.dispose();
    listOfCountriesNotifier.dispose();
    listOfSpeakingLanguageNotifier.dispose();
    listOfSuffix.dispose();
  }
}
