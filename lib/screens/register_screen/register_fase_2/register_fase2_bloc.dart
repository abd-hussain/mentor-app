import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/models/https/suffix_model.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';

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

  ValueNotifier<bool?> validateReferalCode = ValueNotifier<bool?>(null);

  ValueNotifier<List<Country>> listOfCountries = ValueNotifier<List<Country>>([]);
  ValueNotifier<List<SuffixData>> listOfSuffix = ValueNotifier<List<SuffixData>>([]);
  StreamController<LoadingStatus> loadingStatusController = StreamController<LoadingStatus>();

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
    loadingStatusController.sink.add(LoadingStatus.inprogress);
    locator<FilterService>().suffix().then((value) {
      listOfSuffix.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      loadingStatusController.sink.add(LoadingStatus.finish);
    });
  }

  void getlistOfCountries() {
    loadingStatusController.sink.add(LoadingStatus.inprogress);
    locator<FilterService>().countries().then((value) {
      listOfCountries.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      loadingStatusController.sink.add(LoadingStatus.finish);
    });
  }

  void validateReferal(String code) {
    locator<FilterService>().validateReferalCode(code).then((value) {
      validateReferalCode.value = value;
    });
  }
}
