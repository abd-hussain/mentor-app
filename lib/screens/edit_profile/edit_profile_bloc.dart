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
  ValueNotifier<LoadingStatus> loadingStatusNotifier = ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  ValueNotifier<bool> enableSaveButtonNotifier = ValueNotifier<bool>(false);
  ValueNotifier<List<Country>> listOfCountriesNotifier = ValueNotifier<List<Country>>([]);
  ValueNotifier<List<CheckBox>> listOfSpeakingLanguageNotifier = ValueNotifier<List<CheckBox>>([]);

  String? selectedDate;

  final box = Hive.box(DatabaseBoxConstant.userInfo);
  TextEditingController suffixNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  ValueNotifier<List<SuffixData>> listOfSuffix = ValueNotifier<List<SuffixData>>([]);

  String profileImageUrl = "";
  File? profileImage;

  String iDImageUrl = "";
  File? iDImage;

  Country? selectedCountry;

  validateFields() {
    enableSaveButtonNotifier.value = false;
    if (suffixNameController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        (profileImageUrl != "" || profileImage != null) &&
        selectedCountry != null &&
        genderController.text != "" &&
        mobileNumberController.text.isNotEmpty) {
      enableSaveButtonNotifier.value = true;
    }
  }

  void getProfileInformations(BuildContext context) {
    loadingStatusNotifier.value = LoadingStatus.inprogress;
    service.getProfileInfo().then((value) {
      if (value.data != null) {
        if (value.data!.suffixeName != null) {
          suffixNameController.text = value.data!.suffixeName!;
        }
        if (value.data!.firstName != null) {
          firstNameController.text = value.data!.firstName!;
        }
        if (value.data!.lastName != null) {
          lastNameController.text = value.data!.lastName!;
        }
        if (value.data!.email != null) {
          emailController.text = value.data!.email!;
        }
        if (value.data!.mobileNumber != null) {
          mobileNumberController.text = value.data!.mobileNumber!;
        }
        if (value.data!.referalCode != null) {
          referalCodeController.text = value.data!.referalCode!;
        }

        if (value.data!.profileImg != null) {
          profileImageUrl = value.data!.profileImg!;
        }

        if (value.data!.idImg != null) {
          iDImageUrl = value.data!.idImg!;
        }

        if (value.data!.dateOfBirth != null) {
          selectedDate = value.data!.dateOfBirth!;
        }

        if (value.data!.dBCountries != null) {
          selectedCountry = Country(
              id: value.data!.dBCountries!.id!,
              flagImage: value.data!.dBCountries!.flagImage!,
              name: box.get(DatabaseFieldConstant.language) == "en"
                  ? value.data!.dBCountries!.nameEnglish!
                  : value.data!.dBCountries!.nameArabic!,
              currency: box.get(DatabaseFieldConstant.language) == "en"
                  ? value.data!.dBCountries!.currencyEnglish!
                  : value.data!.dBCountries!.currencyArabic!,
              prefixNumber: value.data!.dBCountries!.prefixNumber!);

          countryController.text = box.get(DatabaseFieldConstant.language) == "en"
              ? value.data!.dBCountries!.nameEnglish!
              : value.data!.dBCountries!.nameArabic!;
        }

        if (value.data!.gender != null) {
          if (value.data!.gender! == 0) {
            genderController.text = AppLocalizations.of(context)!.gendermale;
          } else if (value.data!.gender! == 1) {
            genderController.text = AppLocalizations.of(context)!.genderfemale;
          } else {
            genderController.text = AppLocalizations.of(context)!.genderother;
          }
        }

        if (value.data!.speakingLanguage != null) {
          listOfSpeakingLanguageNotifier.value = _prepareList(value.data!.speakingLanguage!);
        }
      }

      loadingStatusNotifier.value = LoadingStatus.finish;
    });
  }

  void getListOfCountries(BuildContext context) {
    loadingStatusNotifier.value = LoadingStatus.inprogress;

    locator<FilterService>().countries().then((value) async {
      listOfCountriesNotifier.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
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
    list.add(CheckBox(value: "English", isEnable: theList.contains("English")));
    list.add(CheckBox(value: "العربية", isEnable: theList.contains("العربية")));
    list.add(CheckBox(value: "Français", isEnable: theList.contains("Français")));
    list.add(CheckBox(value: "Español", isEnable: theList.contains("Español")));
    list.add(CheckBox(value: "Türkçe", isEnable: theList.contains("Türkçe")));

    return list;
  }

  Future updateProfileInfo(BuildContext context) async {
    UpdateAccountRequest account = UpdateAccountRequest(
        suffix: suffixNameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        profileImage: profileImage,
        iDImage: iDImage,
        countryId: selectedCountry!.id!,
        mobileNumber: mobileNumberController.text,
        dateOfBirth: selectedDate!,
        gender: GenderFormat().convertStringToIndex(context, genderController.text));
    //TODO There is Problem In Speacking Language
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
