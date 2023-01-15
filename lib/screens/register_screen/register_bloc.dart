import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';

class RegisterBloc {
  String profileImageUrl = "";
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

  File? profileImage;
  Country? selectedCountry;

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  List<Country> listOfCountries = [];

  validateFields() {}
}
