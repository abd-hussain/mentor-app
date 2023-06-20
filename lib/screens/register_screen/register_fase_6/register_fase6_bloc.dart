import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/pin_field.dart';
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

  OTPSTATUS pinCode1 = OTPSTATUS.idk;
  OTPSTATUS pinCode2 = OTPSTATUS.idk;

  validateFieldsForFaze6() {
    emailFieldShowingStatusValidated.value = _validateEmail(emailController.text);
    mobileFieldShowingStatusValidated.value = mobileNumber.isNotEmpty;

    enableNextBtn.value = pinCode1 == OTPSTATUS.valid && pinCode2 == OTPSTATUS.valid;
  }

  handleListeners() {
    emailOTPController.addListener(() {
      validateFieldsForFaze6();
    });
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
