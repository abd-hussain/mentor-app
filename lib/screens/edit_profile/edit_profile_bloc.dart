import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/gender_model.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class EditProfileBloc extends Bloc<AccountService> {
  bool enableSaveButton = false;
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
  List<Country> listOfCountries = [];

  validateFields() {}

  @override
  onDispose() {}
}
