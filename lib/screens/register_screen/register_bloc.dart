import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';

class RegisterBloc {
  String profileImageUrl = "";
  String iDImageUrl = "";
  String? selectedDate;

  final box = Hive.box(DatabaseBoxConstant.userInfo);
  TextEditingController suffixNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();

  File? profileImage;
  File? iDImage;
  Country? selectedCountry;

  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  List<Country> listOfCountries = [];

  validateFieldsForFaze2() {
    if (suffixNameController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        countryController.text.isNotEmpty) {
      enableNextBtn.value = true;
    }
  }
}
