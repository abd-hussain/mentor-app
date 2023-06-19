import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';

class Register6Bloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  TextEditingController emailController = TextEditingController();
  TextEditingController emailOTPController = TextEditingController();
  ValueNotifier<bool> emailFieldShowingStatusValidated = ValueNotifier<bool>(false);

  TextEditingController phoneNumberOTPController = TextEditingController();
  ValueNotifier<bool> mobileFieldShowingStatusValidated = ValueNotifier<bool>(false);

  String countryCode = "";
  String mobileNumber = "";
  List<Country> countriesList = [];

  validateFieldsForFaze6() {
    emailFieldShowingStatusValidated.value = _validateEmail(emailController.text);
    // if (emailOTPController.text == "000000") {
    //   fieldShowingStatus.value = FieldCanShow.emailOTPValidated;
    // } else {
    //   fieldShowingStatus.value = FieldCanShow.emailValidated;
    // }

    // if (fieldShowingStatus.value == FieldCanShow.email) {
    //   fieldShowingStatus.value = FieldCanShow.emailOTP;
    // }
    // if (fieldShowingStatus.value == FieldCanShow.phoneNumber) {
    //   fieldShowingStatus.value = FieldCanShow.phoneNumberOTP;
    // }
  }

  handleListeners() {
    emailOTPController.addListener(() {
      validateFieldsForFaze6();
    });
    // confirmPasswordController.addListener(_confirmPasswordListen);
  }

  Country returnSelectedCountryFromDatabase() {
    return Country(
      id: int.parse(box.get(DatabaseFieldConstant.selectedCountryId)),
      flagImage: box.get(DatabaseFieldConstant.selectedCountryFlag),
      name: box.get(DatabaseFieldConstant.selectedCountryName),
      currency: box.get(DatabaseFieldConstant.selectedCountryCurrency),
      dialCode: box.get(DatabaseFieldConstant.selectedCountryDialCode),
      maxLength: int.parse(box.get(DatabaseFieldConstant.selectedCountryMaxLenght)),
      minLength: int.parse(box.get(DatabaseFieldConstant.selectedCountryMinLenght)),
    );
  }

  void listOfCountries() {
    loadingStatus.value = LoadingStatus.inprogress;
    locator<FilterService>().countries().then((value) {
      countriesList = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      loadingStatus.value = LoadingStatus.finish;
    });
  }

  bool _validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
