import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/models/https/suffix_model.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';

class Register2Bloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  TextEditingController suffixNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  String profileImageUrl = "";
  String iDImageUrl = "";
  String? selectedDate;

  File? profileImage;
  File? iDImage;

  Country? selectedCountry;
  SuffixData? selectedSuffix;

  ValueNotifier<List<Country>> listOfCountries = ValueNotifier<List<Country>>([]);
  ValueNotifier<List<SuffixData>> listOfSuffix = ValueNotifier<List<SuffixData>>([]);

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  validateFieldsForFaze2() {
    if (suffixNameController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        profileImage != null &&
        iDImage != null) {
      enableNextBtn.value = true;
    }
  }

  void getlistOfSuffix() {
    locator<FilterService>().suffix().then((value) {
      listOfSuffix.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
    });
  }

  void getlistOfCountries() {
    locator<FilterService>().countries().then((value) {
      listOfCountries.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
    });
  }
}
