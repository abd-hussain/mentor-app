import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Register6Bloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ValueNotifier<bool> showHidePasswordClearNotifier =
      ValueNotifier<bool>(false);
  ValueNotifier<bool> showHideConfirmPasswordClearNotifier =
      ValueNotifier<bool>(false);

  ValueNotifier<bool> passwordEquilConfirmPasswordNotifier =
      ValueNotifier<bool>(false);
  ValueNotifier<bool> passwordMoreThan8CharNotifier =
      ValueNotifier<bool>(false);
  ValueNotifier<bool> passwordHaveNumberNotifier = ValueNotifier<bool>(false);

  TextEditingController emailController = TextEditingController();
  ValueNotifier<String> validateEmail = ValueNotifier<String>("");

  handleListeners() {
    passwordController.addListener(_passwordListen);
    confirmPasswordController.addListener(_confirmPasswordListen);
  }

  void _passwordListen() {
    showHidePasswordClearNotifier.value = passwordController.text.isNotEmpty;
    validateFieldsForFaze6();
  }

  void _confirmPasswordListen() {
    showHideConfirmPasswordClearNotifier.value =
        confirmPasswordController.text.isNotEmpty;
    validateFieldsForFaze6();
  }

  validateEmailMethod(BuildContext context) {
    if (validateEmailRegix()) {
      validateEmail.value = "";
      validateEmailAPI(context);
    } else {
      validateEmail.value = AppLocalizations.of(context)!.emailformatnotvalid;
    }
  }

  validateEmailRegix() {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      return true;
    }

    return false;
  }

  validateEmailAPI(BuildContext context) {
    service.validateEmailAddress(emailController.text).then((value) {
      if (value) {
        validateEmail.value = AppLocalizations.of(context)!.emailalreadyinuse;
      } else {
        validateEmail.value = "";
      }
      validateFieldsForFaze6();
    });
  }

  validateFieldsForFaze6() {
    if (passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      passwordEquilConfirmPasswordNotifier.value =
          (passwordController.text == confirmPasswordController.text);
      passwordMoreThan8CharNotifier.value =
          (passwordController.text.length >= 8 ||
              confirmPasswordController.text.length >= 8);
      passwordHaveNumberNotifier.value =
          (passwordController.text.contains(RegExp(r'[0-9]')) ||
              confirmPasswordController.text.contains(RegExp(r'[0-9]')));

      enableNextBtn.value = passwordEquilConfirmPasswordNotifier.value &&
          passwordMoreThan8CharNotifier.value &&
          passwordHaveNumberNotifier.value &&
          validateEmailRegix();
    }
  }

  @override
  onDispose() {}
}
